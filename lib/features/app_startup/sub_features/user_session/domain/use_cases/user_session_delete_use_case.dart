import 'package:tmdb/core/usecase/usecase.dart';

import '../repositories/user_session_repo.dart';

final class UserSessionDeleteUseCase
    implements UseCaseWithoutParamsAndReturnType {
  final UserSessionRepo _repo;

  UserSessionDeleteUseCase(this._repo);

  @override
  Future<void> get call => _repo.delete;
}
