import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tmdb/domain/repositories/account_details_repo.dart';

final class AccountDetailsUseCaseWatch
    implements UseCaseWithoutAsyncAndParams<Stream<AccountDetailsTableData?>> {
  final AccountDetailsRepo _repo;

  const AccountDetailsUseCaseWatch(this._repo);

  @override
  Stream<AccountDetailsTableData?> get call => _repo.watchAccountDetails;
}
