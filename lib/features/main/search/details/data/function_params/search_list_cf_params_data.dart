import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_list_cf_category.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_list_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class SearchListCFParamsData {
  @JsonKey(name: CFJsonKeys.LIST_CATEGORY)
  final SearchListCFCategory listCategory;
  @JsonKey(name: CFJsonKeys.QUERY)
  final String query;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;

  const SearchListCFParamsData({
    required this.listCategory,
    required this.query,
    required this.pageNo,
  });

  Map<String, dynamic> toJson() => _$SearchListCFParamsDataToJson(this);
}
