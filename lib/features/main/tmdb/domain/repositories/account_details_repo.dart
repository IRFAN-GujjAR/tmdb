import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';

abstract class AccountDetailsRepo {
  Stream<AccountDetailsTableData?> get watchAccountDetails;
  Future<void> loadAccountDetails(String sessionId);
  Future<void> saveAccountDetails(
    int userId,
    AccountDetailsEntity accountDetails,
  );
  Future<void> get deleteAccountDetails;
}
