import 'package:drift/drift.dart';

import '../../../../../../../core/database/app_database.dart';
import '../tables/trending_search_table.dart';

part 'trending_search_dao.g.dart';

@DriftAccessor(tables: [TrendingSearchTable])
class TrendingSearchDao extends DatabaseAccessor<AppDatabase>
    with _$TrendingSearchDaoMixin {
  TrendingSearchDao(AppDatabase db) : super(db);

  Future<void> updateSearches(TrendingSearchTableCompanion entry) =>
      into(trendingSearchTable).insertOnConflictUpdate(entry);

  Stream<TrendingSearchTableData?> watchSearches() =>
      select(trendingSearchTable).watchSingleOrNull();
}
