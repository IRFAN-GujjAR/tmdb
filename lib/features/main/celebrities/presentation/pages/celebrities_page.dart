import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/entities/celebs/celebrity_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/refresh_indicator_widget.dart';
import 'package:tmdb/core/ui/widgets/text_row_widget.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/main/celebrities/domain/entities/celebrities_entity.dart';
import 'package:tmdb/features/main/celebrities/presentation/blocs/celebrities_bloc.dart';
import 'package:tmdb/features/main/celebrities/presentation/widgets/celebrities_popular_widget.dart';
import 'package:tmdb/features/main/celebrities/presentation/widgets/celebrities_trending_widget.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/function_params/celebs_list_cf_params.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/function_params/celebs_list_cf_params_data.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/pages/extra/see_all_celebs_page_extra.dart';
import 'package:tmdb/features/main/home/presentation/pages/home_page.dart';
import 'package:tmdb/main.dart';

import '../../../../../core/ads/ad_utils.dart';
import '../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../core/ui/widgets/custom_error_widget.dart';
import '../../../../../core/ui/widgets/divider_widget.dart';
import '../../../../../core/ui/widgets/loading_widget.dart';

Map<CelebrityCategories, String> celebritiesCategoryName = {
  CelebrityCategories.Popular: 'Popular',
  CelebrityCategories.Trending: 'Trending',
};

class CelebritiesPage extends StatelessWidget {
  const CelebritiesPage({super.key});

  Widget _buildTextRow(
    BuildContext context,
    CelebrityCategories category,
    CelebritiesListEntity celebritiesList,
  ) {
    return TextRowWidget(
      categoryName: celebritiesCategoryName[category]!,
      showSeeAllBtn: true,
      onPressed: () {
        appRouterConfig.push(
          context,
          location: AppRouterPaths.SEE_ALL_CELEBS,
          extra: SeeAllCelebsPageExtra(
            pageTitle: celebritiesCategoryName[category]!,
            celebsList: celebritiesList,
            cfParams:
                CelebsListCFParams(
                  category: CelebsCFCategory.list,
                  data: CelebsListCFParamsData(
                    listCategory: category.cfCategory,
                    pageNo: 1,
                  ),
                ).toJson(),
          ),
        );
      },
    );
  }

  Widget _bodyWidget(
    BuildContext context, {
    required CelebritiesEntity celebs,
    required List<CelebrityEntity> firstHalfPopular,
    required List<CelebrityEntity> secondHalfPopular,
  }) {
    return RefreshIndicatorWidget(
      onRefresh: (completer) {
        context.read<CelebritiesBloc>().add(CelebritiesEventRefresh(completer));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: PagePadding.topPadding,
          bottom: PagePadding.bottomPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextRow(context, CelebrityCategories.Popular, celebs.popular),
            CelebritiesPopularWidget(
              firstHalfPopular: firstHalfPopular,
              secondHalfPopular: secondHalfPopular,
            ),
            isIOS
                ? DividerWidget(topPadding: 10)
                : Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                    child: BannerAdWidget(
                      adUnitId: AdUtils.bannerAdId(
                        context.read<AdsManagerProvider>().bannerAds!.celebsId,
                      ),
                      adSize: AdSize.banner,
                    ),
                  ),
                ),
            _buildTextRow(
              context,
              CelebrityCategories.Trending,
              celebs.trending,
            ),
            CelebritiesTrendingWidget(celebs: celebs.trending.celebrities),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tabName[TabItem.celebs]!)),
      body: CustomBodyWidget(
        child: BlocConsumer<CelebritiesBloc, CelebritiesState>(
          listener: (context, state) {
            if (state is CelebritiesStateErrorWithCache) {
              UIUtl.showSnackBar(context, msg: state.error.error.errorMessage);
            }
          },
          builder: (context, state) {
            switch (state) {
              case CelebritiesStateLoading():
                return LoadingWidget();
              case CelebritiesStateLoaded():
                return _bodyWidget(
                  context,
                  celebs: state.celebrities,
                  firstHalfPopular: state.firstHalfPopular,
                  secondHalfPopular: state.secondHalfPopular,
                );
              case CelebritiesStateErrorWithCache():
                return _bodyWidget(
                  context,
                  celebs: state.celebrities,
                  firstHalfPopular: state.firstHalfPopular,
                  secondHalfPopular: state.secondHalfPopular,
                );
              case CelebritiesStateErrorWithoutCache():
                return CustomErrorWidget(
                  error: state.error,
                  onPressed:
                      () => context.read<CelebritiesBloc>().add(
                        const CelebritiesEventLoad(),
                      ),
                );
            }
          },
        ),
      ),
    );
  }
}
