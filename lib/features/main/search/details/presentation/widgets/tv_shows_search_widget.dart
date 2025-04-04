import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params_data.dart';

import '../../../../../ads_manager/presentation/blocs/ads_manager_bloc.dart';
import '../../../../tv_shows/sub_features/see_all/data/data_sources/see_all_tv_shows_data_source.dart';
import '../../../../tv_shows/sub_features/see_all/data/repositories/see_all_tv_shows_repo_impl.dart';
import '../../../../tv_shows/sub_features/see_all/domain/use_cases/see_all_tv_shows_use_case.dart';
import '../../../../tv_shows/sub_features/see_all/presentation/blocs/see_all_tv_shows_bloc.dart';
import '../../../../tv_shows/sub_features/see_all/presentation/pages/extra/see_all_tv_shows_page_extra.dart';
import '../../../../tv_shows/sub_features/see_all/presentation/providers/see_all_tv_shows_provider.dart';
import '../../../../tv_shows/sub_features/see_all/presentation/widgets/see_all_tv_shows_widget.dart';
import '../providers/search_details_provider.dart';

class TvShowsSearchWidget extends StatefulWidget {
  final TvShowsListEntity tvShowsList;

  const TvShowsSearchWidget({super.key, required this.tvShowsList});

  @override
  State<TvShowsSearchWidget> createState() => _TvShowsSearchWidgetState();
}

class _TvShowsSearchWidgetState extends State<TvShowsSearchWidget>
    with AutomaticKeepAliveClientMixin<TvShowsSearchWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create:
          (context) => SeeAllTvShowsProvider(
            seeAllTvShowsBloc: SeeAllTvShowsBloc(
              context.read<AdsManagerBloc>(),
              SeeAllTvShowsUseCase(
                SeeAllTvShowsRepoImpl(
                  SeeAllTvShowsDataSourceImpl(CloudFunctionsUtl.searchFunction),
                ),
              ),
            ),
            extra: SeeAllTvShowsPageExtra(
              pageTitle: 'Tv Shows',
              tvShowsList: widget.tvShowsList,
              cfParams:
                  SearchListCFParams(
                    category: SearchCFCategory.list,
                    data: SearchListCFParamsData(
                      listCategory: SearchListCFCategory.tv,
                      query: context.read<SearchDetailsProvider>().query,
                      pageNo: 1,
                    ),
                  ).toJson(),
            ),
          ),
      child: SeeAllTvShowsWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
