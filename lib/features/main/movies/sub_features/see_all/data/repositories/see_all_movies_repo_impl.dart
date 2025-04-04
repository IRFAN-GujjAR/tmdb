import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/data_sources/see_all_movies_data_source.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/domain/repositories/see_all_movies_repo.dart';

final class SeeAllMoviesRepoImpl implements SeeAllMoviesRepo {
  final SeeAllMoviesDataSource _dataSource;

  SeeAllMoviesRepoImpl(this._dataSource);

  @override
  Future<MoviesListEntity> getMovies({
    required Map<String, dynamic> cfParams,
  }) async {
    final moviesListModel = await _dataSource.getMovies(cfParams: cfParams);
    final moviesListEntity = MoviesListEntity(
      movies: moviesListModel.movies,
      pageNo: moviesListModel.pageNo,
      totalPages: moviesListModel.totalPages,
    );
    return moviesListEntity;
  }
}
