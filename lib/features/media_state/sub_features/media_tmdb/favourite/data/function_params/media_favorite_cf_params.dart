import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/function_params/media_favorite_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'media_favorite_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MediaFavoriteCFParams {
  final TMDbCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final MediaFavoriteCFParamsData data;

  const MediaFavoriteCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$MediaFavoriteCFParamsToJson(this);
}
