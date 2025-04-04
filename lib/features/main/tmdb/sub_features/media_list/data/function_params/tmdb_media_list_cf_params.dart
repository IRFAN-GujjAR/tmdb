import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';

import '../../../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'tmdb_media_list_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class TMDbMediaListCfParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final TMDbMediaListCfParamsData data;

  const TMDbMediaListCfParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$TMDbMediaListCfParamsToJson(this);
}
