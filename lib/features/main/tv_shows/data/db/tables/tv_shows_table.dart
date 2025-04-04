import 'package:drift/drift.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';

class TvShowsTable extends Table {
  IntColumn get id => integer()();
  BlobColumn get airingToday => blob().map(TvShowsListModel.binaryConverter)();
  BlobColumn get trending => blob().map(TvShowsListModel.binaryConverter)();
  BlobColumn get topRated => blob().map(TvShowsListModel.binaryConverter)();
  BlobColumn get popular => blob().map(TvShowsListModel.binaryConverter)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
