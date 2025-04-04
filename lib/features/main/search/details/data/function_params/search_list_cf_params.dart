import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params_data.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_list_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class SearchListCFParams {
  final SearchCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final SearchListCFParamsData data;

  const SearchListCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$SearchListCFParamsToJson(this);
}
