import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/data/models/user_session_model.dart';
import 'package:tmdb/features/login/data/function_params/login_cf_params.dart';
import 'package:tmdb/features/login/data/function_params/login_cf_params_data.dart';
import 'package:tmdb/features/login/domain/use_cases/params/login_params.dart';

abstract class LoginDataSource {
  Future<UserSessionModel> login(LoginParams params);
}

final class LoginDataSourceImpl extends LoginDataSource {
  final HttpsCallable _function;

  LoginDataSourceImpl(this._function);

  @override
  Future<UserSessionModel> login(LoginParams params) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      LoginCFParams(
        category: TMDbCFCategory.login,
        data: LoginCfParamsData(
          username: params.username,
          password: params.password,
        ),
      ).toJson(),
    );
    return UserSessionModel.fromJson(data);
  }
}
