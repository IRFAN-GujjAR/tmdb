import 'package:tmdb/core/usecase/usecase.dart';

import '../entities/user_session_entity.dart';
import '../repositories/user_session_repo.dart';

final class UserSessionLoadUseCase
    implements UseCaseWithoutParams<UserSessionEntity> {
  final UserSessionRepo _repo;

  UserSessionLoadUseCase(this._repo);

  @override
  Future<UserSessionEntity> get call => _repo.load;
}
