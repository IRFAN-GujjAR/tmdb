import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/tmdb/data/data_sources/account_details_local_data_source.dart';
import 'package:tmdb/features/main/tmdb/data/data_sources/account_details_remote_data_source.dart';
import 'package:tmdb/features/main/tmdb/data/models/account_details_model.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';
import 'package:tmdb/features/main/tmdb/domain/repositories/account_details_repo.dart';

final class AccountDetailsRepoImpl implements AccountDetailsRepo {
  final AccountDetailsLocalDataSource _localDataSource;
  final AccountDetailsRemoteDataSource _remoteDataSource;

  const AccountDetailsRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> loadAccountDetails(String sessionId) async {
    final accountDetails = await _remoteDataSource.loadAccountDetails(
      sessionId,
    );
    return _localDataSource.saveAccountDetails(accountDetails);
  }

  @override
  Stream<AccountDetailsTableData?> get watchAccountDetails =>
      _localDataSource.watchAccountDetails;

  @override
  Future<void> saveAccountDetails(
    int userId,
    AccountDetailsEntity accountDetails,
  ) => _localDataSource.saveAccountDetails(
    AccountDetailsModel(
      id: userId,
      username: accountDetails.username,
      avatar: AvatarModel(AvatarPathModel(accountDetails.profilePath)),
    ),
  );

  @override
  Future<void> get deleteAccountDetails =>
      _localDataSource.deleteAccountDetails;
}
