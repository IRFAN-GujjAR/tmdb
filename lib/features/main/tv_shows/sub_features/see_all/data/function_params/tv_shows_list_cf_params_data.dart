import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_list_cf_category.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'tv_shows_list_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class TvShowsListCFParamsData {
  @JsonKey(name: CFJsonKeys.LIST_CATEGORY)
  final TvShowsListCFCategory listCategory;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;
  @JsonKey(name: CFJsonKeys.TV_ID)
  final int? tvId;

  const TvShowsListCFParamsData({
    required this.listCategory,
    required this.pageNo,
    required this.tvId,
  });

  Map<String, dynamic> toJson() => _$TvShowsListCFParamsDataToJson(this);
}
