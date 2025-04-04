import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';

part 'movies_cf_params.g.dart';

@JsonSerializable(createFactory: false)
final class MoviesCFParams {
  final MoviesCFCategory category;

  const MoviesCFParams({required this.category});

  Map<String, dynamic> toJson() => _$MoviesCFParamsToJson(this);
}
