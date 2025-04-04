import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';
import 'package:tmdb/features/login/domain/repositories/login_repo.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

final class LoginUseCase implements UseCase<UserSessionEntity, LoginParams> {
  final LoginRepo _loginRepo;

  LoginUseCase(this._loginRepo);

  @override
  Future<UserSessionEntity> call(LoginParams params) async =>
      await _loginRepo.login(params);
}
