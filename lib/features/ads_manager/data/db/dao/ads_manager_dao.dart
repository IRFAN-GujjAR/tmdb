import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';

import '../tables/ads_manager_table.dart';

part 'ads_manager_dao.g.dart';

@DriftAccessor(tables: [AdsManagerTable])
class AdsManagerDao extends DatabaseAccessor<AppDatabase>
    with _$AdsManagerDaoMixin {
  AdsManagerDao(super.attachedDatabase);

  Future<void> updateCounter(AdsManagerTableCompanion entry) =>
      into(adsManagerTable).insertOnConflictUpdate(entry);

  Stream<AdsManagerTableData?> get watchCounter =>
      select(adsManagerTable).watchSingleOrNull();
}
