import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';

part 'trending_search_cf_params.g.dart';

@JsonSerializable(createFactory: false)
final class TrendingSearchCFParams {
  final SearchCFCategory category;

  const TrendingSearchCFParams({required this.category});

  Map<String, dynamic> toJson() => _$TrendingSearchCFParamsToJson(this);
}
