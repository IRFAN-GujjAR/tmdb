import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/movies/data/models/movies_model.dart';

import '../db/dao/movies_dao.dart';

abstract class MoviesLocalDataSource {
  Stream<MoviesTableData?> get watchMovies;
  Future<void> cacheData(MoviesModel movies);
}

final class MoviesLocalDataSourceImpl implements MoviesLocalDataSource {
  final MoviesDao _moviesDao;

  MoviesLocalDataSourceImpl(this._moviesDao);

  @override
  Stream<MoviesTableData?> get watchMovies {
    return _moviesDao.watchMovies();
  }

  @override
  Future<void> cacheData(MoviesModel movies) async {
    return _moviesDao.updateMovies(
      MoviesTableCompanion(
        id: Value(0),
        popular: Value(movies.popular),
        inTheatre: Value(movies.inTheatres),
        trending: Value(movies.trending),
        topRated: Value(movies.topRated),
        upComing: Value(movies.upComing),
      ),
    );
  }
}
