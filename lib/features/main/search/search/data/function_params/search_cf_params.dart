import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/features/main/search/search/data/function_params/search_cf_params_data.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class SearchCFParams {
  final SearchCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final SearchCFParamsData data;

  const SearchCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$SearchCFParamsToJson(this);
}
