import 'package:json_annotation/json_annotation.dart';

part 'login_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class LoginCfParamsData {
  final String username;
  final String password;

  const LoginCfParamsData({required this.username, required this.password});

  Map<String, dynamic> toJson() => _$LoginCfParamsDataToJson(this);
}
