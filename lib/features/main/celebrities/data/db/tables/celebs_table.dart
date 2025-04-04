import 'package:drift/drift.dart';
import 'package:tmdb/core/models/celebs/celebrities_list_model.dart';

class CelebsTable extends Table {
  IntColumn get id => integer()();
  BlobColumn get popular => blob().map(CelebritiesListModel.binaryConverter)();
  BlobColumn get trending => blob().map(CelebritiesListModel.binaryConverter)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
