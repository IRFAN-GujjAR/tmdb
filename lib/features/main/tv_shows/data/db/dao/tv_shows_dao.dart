import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';

import '../tables/tv_shows_table.dart';

part 'tv_shows_dao.g.dart';

@DriftAccessor(tables: [TvShowsTable])
class TvShowsDao extends DatabaseAccessor<AppDatabase> with _$TvShowsDaoMixin {
  TvShowsDao(AppDatabase db) : super(db);

  Future<void> updateTvShows(TvShowsTableCompanion entry) =>
      into(tvShowsTable).insertOnConflictUpdate(entry);

  Stream<TvShowsTableData?> watchTvShows() =>
      select(tvShowsTable).watchSingleOrNull();
}
