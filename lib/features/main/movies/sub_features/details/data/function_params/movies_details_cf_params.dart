import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/function_params/movie_details_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'movies_details_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MovieDetailsCFParams {
  final MoviesCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final MovieDetailsCFParamsData data;

  const MovieDetailsCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$MovieDetailsCFParamsToJson(this);
}
