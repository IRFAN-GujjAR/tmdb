import 'package:tmdb/features/app_startup/sub_features/user_session/data/models/user_session_model.dart';
import 'package:tmdb/features/login/data/data_sources/login_data_source.dart';
import 'package:tmdb/features/login/domain/repositories/login_repo.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

final class LoginRepoImpl implements LoginRepo {
  final LoginDataSource _dataSource;

  LoginRepoImpl(this._dataSource);

  @override
  Future<UserSessionModel> login(LoginParams params) async =>
      await _dataSource.login(params);
}
