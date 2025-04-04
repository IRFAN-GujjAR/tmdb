import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/function_params/movies_list_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'movies_list_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MoviesListCFParams {
  final MoviesCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final MoviesListCFParamsData data;

  const MoviesListCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$MoviesListCFParamsToJson(this);
}
