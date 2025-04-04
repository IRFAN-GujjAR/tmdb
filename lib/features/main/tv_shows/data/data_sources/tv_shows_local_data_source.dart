import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/tv_shows/data/db/dao/tv_shows_dao.dart';
import 'package:tmdb/features/main/tv_shows/data/models/tv_shows_model.dart';

abstract class TvShowsLocalDataSource {
  Stream<TvShowsTableData?> get watchTvShows;
  Future<void> cacheData(TvShowsModel tvShows);
}

final class TvShowsLocalDataSourceImpl implements TvShowsLocalDataSource {
  final TvShowsDao _dao;

  const TvShowsLocalDataSourceImpl(this._dao);

  @override
  Stream<TvShowsTableData?> get watchTvShows => _dao.watchTvShows();

  @override
  Future<void> cacheData(TvShowsModel tvShows) => _dao.updateTvShows(
    TvShowsTableCompanion(
      id: Value(0),
      airingToday: Value(tvShows.airingToday),
      trending: Value(tvShows.trending),
      topRated: Value(tvShows.topRated),
      popular: Value(tvShows.popular),
    ),
  );
}
