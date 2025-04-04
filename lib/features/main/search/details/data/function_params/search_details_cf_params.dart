import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_details_cf_params_data.dart';

import '../../../../../../core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_details_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class SearchDetailsCFParams {
  final SearchCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final SearchDetailsCFParamsData data;

  const SearchDetailsCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$SearchDetailsCFParamsToJson(this);
}
