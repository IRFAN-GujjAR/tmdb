import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tmdb/domain/repositories/account_details_repo.dart';

final class AccountDetailsUseCaseDelete
    implements UseCaseWithoutParamsAndReturnType {
  final AccountDetailsRepo _repo;

  const AccountDetailsUseCaseDelete(this._repo);

  @override
  Future<void> get call => _repo.deleteAccountDetails;
}
