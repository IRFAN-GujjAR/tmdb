import 'package:drift/drift.dart';

import '../../../../../../core/database/app_database.dart';
import '../tables/celebs_table.dart';

part 'celebs_dao.g.dart';

@DriftAccessor(tables: [CelebsTable])
class CelebsDao extends DatabaseAccessor<AppDatabase> with _$CelebsDaoMixin {
  CelebsDao(AppDatabase db) : super(db);

  Future<void> updateCelebs(CelebsTableCompanion entry) =>
      into(celebsTable).insertOnConflictUpdate(entry);

  Stream<CelebsTableData?> watchCelebs() =>
      select(celebsTable).watchSingleOrNull();
}
