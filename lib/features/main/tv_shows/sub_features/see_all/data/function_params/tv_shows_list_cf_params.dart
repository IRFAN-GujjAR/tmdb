import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/data/function_params/tv_shows_list_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'tv_shows_list_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class TvShowsListCFParams {
  final TvShowsCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final TvShowsListCFParamsData data;

  const TvShowsListCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$TvShowsListCFParamsToJson(this);
}
