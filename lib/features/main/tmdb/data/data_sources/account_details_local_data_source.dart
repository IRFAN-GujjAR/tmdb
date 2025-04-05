import 'package:tmdb/core/database/app_database.dart';

abstract class AccountDetailsLocalDataSource {
  Stream<AccountDetailsTableData?> get watchAccountDetails;
  Future<void> saveAccountDetails(AccountDetailsTableData accountDetails);
}
