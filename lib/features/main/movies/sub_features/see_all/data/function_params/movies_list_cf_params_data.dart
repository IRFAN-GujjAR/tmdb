import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'movies_list_cf_params_data.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MoviesListCFParamsData {
  @JsonKey(name: CFJsonKeys.LIST_CATEGORY)
  final MoviesListCFCategory listCategory;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;
  @JsonKey(name: CFJsonKeys.MOVIE_ID)
  final int? movieId;

  const MoviesListCFParamsData({
    required this.listCategory,
    required this.pageNo,
    required this.movieId,
  });

  Map<String, dynamic> toJson() => _$MoviesListCFParamsDataToJson(this);
}
