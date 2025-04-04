import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/data_sources/tmdb_media_list_data_source.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/entities/tmdb_media_list_entity.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/repositories/tmdb_media_list_repo.dart';

import '../../../../../../../core/entities/movie/movies_list_entity.dart';
import '../../../../../../../core/entities/tv_show/tv_shows_list_entity.dart';
import '../function_params/tmdb_media_list_cf_params_data.dart';

final class TMDbMediaListRepoImpl implements TMDbMediaListRepo {
  final TMDbMediaListDataSource _dataSource;

  const TMDbMediaListRepoImpl(this._dataSource);

  @override
  Future<TMDbMediaListEntity> loadMediaList(
    TMDbMediaListCfParamsData cfParamsData,
  ) async {
    final model = await _dataSource.loadMediaList(cfParamsData);
    return TMDbMediaListEntity(
      moviesList: MoviesListEntity(
        pageNo: model.moviesList.pageNo,
        totalPages: model.moviesList.totalPages,
        movies: model.moviesList.movies,
      ),
      tvShowsList: TvShowsListEntity(
        pageNo: model.tvShowsList.pageNo,
        totalPages: model.tvShowsList.totalPages,
        tvShows: model.tvShowsList.tvShows,
      ),
    );
  }
}
