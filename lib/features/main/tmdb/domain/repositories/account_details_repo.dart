import 'package:tmdb/core/database/app_database.dart';

abstract class AccountDetailsRepo {
  Stream<AccountDetailsTableData?> get watchAccountDetails;
  Future<void> loadAccountDetails(String sessionId);
}
