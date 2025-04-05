import 'package:tmdb/features/login/data/data_sources/login_data_source.dart';
import 'package:tmdb/features/login/domain/entities/login_entity.dart';
import 'package:tmdb/features/login/domain/repositories/login_repo.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

final class LoginRepoImpl implements LoginRepo {
  final LoginDataSource _dataSource;

  LoginRepoImpl(this._dataSource);

  @override
  Future<LoginEntity> login(LoginParams params) async {
    final model = await _dataSource.login(params);
    return LoginEntity(
      sessionId: model.sessionId,
      userId: model.accountDetails.id,
      username: model.accountDetails.username,
      profilePath: model.accountDetails.avatar.avatarPath.profilePath,
    );
  }
}
