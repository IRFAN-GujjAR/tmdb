import 'package:tmdb/core/database/app_database.dart';

abstract class TvShowsRepo {
  Future<void> get loadTvShows;
  Stream<TvShowsTableData?> get watchTvShows;
}
