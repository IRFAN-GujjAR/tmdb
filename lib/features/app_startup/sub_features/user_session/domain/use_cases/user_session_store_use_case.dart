import 'package:tmdb/core/usecase/usecase.dart';

import '../entities/user_session_entity.dart';
import '../repositories/user_session_repo.dart';

final class UserSessionStoreUseCase
    implements UseCaseWithoutReturnType<UserSessionEntity> {
  final UserSessionRepo _repo;

  UserSessionStoreUseCase(this._repo);

  @override
  Future<void> call(UserSessionEntity params) => _repo.store(params);
}
