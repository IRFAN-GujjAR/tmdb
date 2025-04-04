import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';

import '../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'media_state_cf_params_data.dart';

part 'media_state_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MediaStateCFParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final MediaStateCFParamsData data;

  const MediaStateCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$MediaStateCFParamsToJson(this);
}
