import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/data/function_params/tv_show_details_cf_params_data.dart';

part 'tv_show_details_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class TvShowDetailsCFParams {
  final TvShowsCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final TvShowDetailsCFParamsData data;

  const TvShowDetailsCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$TvShowDetailsCFParamsToJson(this);
}
