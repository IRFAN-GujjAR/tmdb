import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/tmdb/data/db/dao/account_details_dao.dart';
import 'package:tmdb/features/main/tmdb/data/models/account_details_model.dart';

abstract class AccountDetailsLocalDataSource {
  Stream<AccountDetailsTableData?> get watchAccountDetails;
  Future<void> saveAccountDetails(AccountDetailsModel accountDetails);
  Future<void> get deleteAccountDetails;
}

final class AccountDetailsLocalDataSourceImpl
    implements AccountDetailsLocalDataSource {
  final AccountDetailsDao _dao;

  const AccountDetailsLocalDataSourceImpl(this._dao);

  @override
  Future<void> saveAccountDetails(AccountDetailsModel accountDetails) =>
      _dao.saveAccountDetails(
        AccountDetailsTableCompanion(
          id: Value(0),
          username: Value(accountDetails.username),
          profilePath: Value(accountDetails.avatar.avatarPath.profilePath),
        ),
      );

  @override
  Stream<AccountDetailsTableData?> get watchAccountDetails =>
      _dao.watchAccountDetails;

  @override
  Future<void> get deleteAccountDetails => _dao.deleteAccountDetails;
}
