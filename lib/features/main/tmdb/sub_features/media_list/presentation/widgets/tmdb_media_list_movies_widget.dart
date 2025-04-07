import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/entities/tmdb_media_list_entity.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_provider.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_scroll_controller_provider.dart';

import '../../../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import '../../../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import '../../../../../../../core/firebase/cloud_functions/cloud_functions_utl.dart';
import '../../../../../movies/sub_features/see_all/data/data_sources/see_all_movies_data_source.dart';
import '../../../../../movies/sub_features/see_all/data/repositories/see_all_movies_repo_impl.dart';
import '../../../../../movies/sub_features/see_all/domain/use_cases/see_all_movies_use_case.dart';
import '../../../../../movies/sub_features/see_all/presentation/blocs/see_all_movies_bloc.dart';
import '../../../../../movies/sub_features/see_all/presentation/pages/extra/see_all_movies_page_extra.dart';
import '../../../../../movies/sub_features/see_all/presentation/providers/see_all_movies_provider.dart';
import '../../../../../movies/sub_features/see_all/presentation/widgets/see_all_movies_widget.dart';
import '../../data/function_params/tmdb_media_list_cf_params.dart';

class TMDbMediaListMoviesWidget extends StatefulWidget {
  final TMDbMediaListCFCategory listCFCategory;
  final TMDbMediaListEntity tMDBMediaList;

  const TMDbMediaListMoviesWidget({
    super.key,
    required this.listCFCategory,
    required this.tMDBMediaList,
  });

  @override
  State<TMDbMediaListMoviesWidget> createState() =>
      _TMDbMediaListMoviesWidgetState();
}

class _TMDbMediaListMoviesWidgetState extends State<TMDbMediaListMoviesWidget>
    with AutomaticKeepAliveClientMixin<TMDbMediaListMoviesWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create:
          (BuildContext context) => SeeAllMoviesProvider(
            seeAllMoviesBloc: SeeAllMoviesBloc(
              context.read<AdsManagerBloc>(),
              SeeAllMoviesUseCase(
                SeeAllMoviesRepoImpl(
                  SeeAllMoviesDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                ),
              ),
            ),
            extra: SeeAllMoviesPageExtra(
              pageTitle: widget.listCFCategory.title,
              moviesList: widget.tMDBMediaList.moviesList,
              cfParams:
                  TMDbMediaListCfParams(
                    category: TMDbCFCategory.mediaList,
                    data:
                        context
                            .read<TMDbMediaListProvider>()
                            .paramsData
                            .movieList,
                  ).toJson(),
            ),
            scrollControllerUtl:
                widget.tMDBMediaList.isBoth
                    ? context
                        .read<TMDbMediaListScrollControllerProvider>()
                        .scrollControllerUtil1
                    : null,
          ),
      child: const SeeAllMoviesWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
