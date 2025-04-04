import 'package:drift/drift.dart';

import '../../../../../../../core/models/search/searches_model.dart';

class TrendingSearchTable extends Table {
  IntColumn get id => integer()();
  BlobColumn get trendingSearch => blob().map(SearchesModel.binaryConverter)();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
