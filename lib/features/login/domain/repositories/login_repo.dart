import 'package:tmdb/features/app_startup/sub_features/user_session/domain/entities/user_session_entity.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

abstract class LoginRepo {
  Future<UserSessionEntity> login(LoginParams params);
}
