import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tmdb/domain/repositories/account_details_repo.dart';
import 'package:tmdb/features/main/tmdb/domain/use_cases/params/account_details_params_save.dart';

final class AccountDetailsUseCaseSave
    implements UseCaseWithoutReturnType<AccountDetailsParamsSave> {
  final AccountDetailsRepo _repo;

  const AccountDetailsUseCaseSave(this._repo);

  @override
  Future<void> call(AccountDetailsParamsSave params) =>
      _repo.saveAccountDetails(params.userId, params.accountDetails);
}
