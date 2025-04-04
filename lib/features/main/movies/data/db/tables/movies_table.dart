import 'package:drift/drift.dart';

import '../../../../../../core/models/movie/movies_list_model.dart';

class MoviesTable extends Table {
  IntColumn get id => integer()();
  BlobColumn get popular => blob().map(MoviesListModel.binaryConverter)();
  BlobColumn get inTheatre => blob().map(MoviesListModel.binaryConverter)();
  BlobColumn get trending => blob().map(MoviesListModel.binaryConverter)();
  BlobColumn get topRated => blob().map(MoviesListModel.binaryConverter)();
  BlobColumn get upComing => blob().map(MoviesListModel.binaryConverter)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
