import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/function_params/celebs_list_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'celebs_list_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class CelebsListCFParams {
  final CelebsCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final CelebsListCFParamsData data;

  const CelebsListCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$CelebsListCFParamsToJson(this);
}
