import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tmdb/domain/repositories/account_details_repo.dart';

final class AccountDetailsUseCaseLoad
    implements UseCaseWithoutReturnType<String> {
  final AccountDetailsRepo _repo;

  const AccountDetailsUseCaseLoad(this._repo);

  @override
  Future<void> call(String sessionId) => _repo.loadAccountDetails(sessionId);
}
