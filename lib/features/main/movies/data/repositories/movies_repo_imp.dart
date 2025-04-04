import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/movies/data/data_sources/movies_local_data_source.dart';
import 'package:tmdb/features/main/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:tmdb/features/main/movies/data/models/movies_model.dart';
import 'package:tmdb/features/main/movies/domain/repositories/movies_repo.dart';

final class MoviesRepoImpl implements MoviesRepo {
  final MoviesLocalDataSource _localDataSource;
  final MoviesRemoteDataSource _remoteDataSource;

  MoviesRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> get loadMovies async {
    final model = await _remoteDataSource.loadMovies;
    return _localDataSource.cacheData(model);
  }

  Future<void> cacheData(MoviesModel movies) =>
      _localDataSource.cacheData(movies);

  @override
  Stream<MoviesTableData?> get watchMovies => _localDataSource.watchMovies;
}
