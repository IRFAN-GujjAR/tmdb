import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/function_params/season_cf_params_data.dart';

part 'season_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class SeasonCFParams {
  final TvShowsCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final SeasonCFParamsData data;

  const SeasonCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$SeasonCFParamsToJson(this);
}
