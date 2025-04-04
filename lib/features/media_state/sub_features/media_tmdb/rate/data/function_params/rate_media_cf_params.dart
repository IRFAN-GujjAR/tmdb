import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/function_params/rate_media_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'rate_media_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class RateMediaCFParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final RateMediaCFParamsData data;

  const RateMediaCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$RateMediaCFParamsToJson(this);
}
