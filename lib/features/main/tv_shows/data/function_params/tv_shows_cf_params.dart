import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';

part 'tv_shows_cf_params.g.dart';

@JsonSerializable(createFactory: false)
final class TvShowsCFParams {
  final TvShowsCFCategory category;

  const TvShowsCFParams({required this.category});

  Map<String, dynamic> toJson() => _$TvShowsCFParamsToJson(this);
}
