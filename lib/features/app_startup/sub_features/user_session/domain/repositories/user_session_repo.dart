import '../entities/user_session_entity.dart';

abstract class UserSessionRepo {
  Future<UserSessionEntity> get load;
  Future<void> store(UserSessionEntity userSession);
  Future<void> get delete;
}
