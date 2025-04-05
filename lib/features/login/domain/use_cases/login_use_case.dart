import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/login/domain/entities/login_entity.dart';
import 'package:tmdb/features/login/domain/repositories/login_repo.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

final class LoginUseCase implements UseCase<LoginEntity, LoginParams> {
  final LoginRepo _loginRepo;

  LoginUseCase(this._loginRepo);

  @override
  Future<LoginEntity> call(LoginParams params) async =>
      await _loginRepo.login(params);
}
