import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';

import '../tables/account_details_table.dart';

part 'account_details_dao.g.dart';

@DriftAccessor(tables: [AccountDetailsTable])
class AccountDetailsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountDetailsDaoMixin {
  AccountDetailsDao(super.attachedDatabase);

  Stream<AccountDetailsTableData?> get watchAccountDetails =>
      select(accountDetailsTable).watchSingleOrNull();

  Future<void> insertAccountDetails(AccountDetailsTableCompanion entry) =>
      into(accountDetailsTable).insertOnConflictUpdate(entry);
}
