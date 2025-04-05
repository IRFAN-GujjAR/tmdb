import '../../domain/entities/user_session_entity.dart';
import '../../domain/repositories/user_session_repo.dart';
import '../data_sources/user_session_data_source.dart';
import '../models/user_session_model.dart';

final class UserSessionRepoImpl implements UserSessionRepo {
  final UserSessionDataSource _dataSource;

  UserSessionRepoImpl(this._dataSource);

  @override
  Future<UserSessionModel> get load => _dataSource.load;

  @override
  Future<void> store(UserSessionEntity userSession) => _dataSource.store(
    UserSessionModel(
      userId: userSession.userId,
      sessionId: userSession.sessionId,
    ),
  );

  @override
  Future<void> get delete => _dataSource.delete;
}
