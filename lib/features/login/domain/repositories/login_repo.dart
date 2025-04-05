import 'package:tmdb/features/login/domain/entities/login_entity.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

abstract class LoginRepo {
  Future<LoginEntity> login(LoginParams params);
}
