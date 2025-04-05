import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/features/main/tmdb/data/function_params/account_details_cf_params_data.dart';

import '../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'account_details_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class AccountDetailsCFParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final AccountDetailsCFParamsData data;

  const AccountDetailsCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$AccountDetailsCFParamsToJson(this);
}
