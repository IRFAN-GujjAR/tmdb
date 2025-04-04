import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_provider.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_scroll_controller_provider.dart';

import '../../../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import '../../../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import '../../../../../../../core/firebase/cloud_functions/cloud_functions_utl.dart';
import '../../../../../../ads_manager/presentation/blocs/ads_manager_bloc.dart';
import '../../../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import '../../../../../tv_shows/sub_features/see_all/data/data_sources/see_all_tv_shows_data_source.dart';
import '../../../../../tv_shows/sub_features/see_all/data/repositories/see_all_tv_shows_repo_impl.dart';
import '../../../../../tv_shows/sub_features/see_all/domain/use_cases/see_all_tv_shows_use_case.dart';
import '../../../../../tv_shows/sub_features/see_all/presentation/blocs/see_all_tv_shows_bloc.dart';
import '../../../../../tv_shows/sub_features/see_all/presentation/pages/extra/see_all_tv_shows_page_extra.dart';
import '../../../../../tv_shows/sub_features/see_all/presentation/providers/see_all_tv_shows_provider.dart';
import '../../../../../tv_shows/sub_features/see_all/presentation/widgets/see_all_tv_shows_widget.dart';
import '../../data/function_params/tmdb_media_list_cf_params.dart';
import '../../domain/entities/tmdb_media_list_entity.dart';

class TMDbMediaListTvShowsWidget extends StatefulWidget {
  final TMDbMediaListCFCategory listCFCategory;
  final TMDbMediaListEntity tMDBMediaList;

  const TMDbMediaListTvShowsWidget({
    super.key,
    required this.listCFCategory,
    required this.tMDBMediaList,
  });

  @override
  State<TMDbMediaListTvShowsWidget> createState() =>
      _TMDbMediaListTvShowsWidget();
}

class _TMDbMediaListTvShowsWidget extends State<TMDbMediaListTvShowsWidget>
    with AutomaticKeepAliveClientMixin<TMDbMediaListTvShowsWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final user = context.read<UserSessionProvider>().userSession;
    return ChangeNotifierProvider(
      create:
          (BuildContext context) => SeeAllTvShowsProvider(
            seeAllTvShowsBloc: SeeAllTvShowsBloc(
              context.read<AdsManagerBloc>(),
              SeeAllTvShowsUseCase(
                SeeAllTvShowsRepoImpl(
                  SeeAllTvShowsDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                ),
              ),
            ),
            extra: SeeAllTvShowsPageExtra(
              pageTitle: widget.listCFCategory.title,
              tvShowsList: widget.tMDBMediaList.tvShowsList,
              cfParams:
                  TMDbMediaListCfParams(
                    category: TMDbCFCategory.mediaList,
                    data:
                        context
                            .read<TMDbMediaListProvider>()
                            .paramsData
                            .tvShowsList,
                  ).toJson(),
            ),
            scrollControllerUtl:
                widget.tMDBMediaList.isBoth
                    ? context
                        .read<TMDbMediaListScrollControllerProvider>()
                        .scrollControllerUtil2
                    : null,
          ),
      child: const SeeAllTvShowsWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
