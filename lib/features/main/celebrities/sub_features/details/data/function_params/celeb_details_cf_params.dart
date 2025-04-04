import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/function_params/celeb_details_cf_params_data.dart';

part 'celeb_details_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class CelebDetailsCfParams {
  final CelebsCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final CelebDetailsCfParamsData data;

  const CelebDetailsCfParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$CelebDetailsCfParamsToJson(this);
}
