import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/login/data/function_params/login_cf_params_data.dart';

part 'login_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class LoginCFParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final LoginCfParamsData data;
  const LoginCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$LoginCFParamsToJson(this);
}
