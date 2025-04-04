import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class SearchCFParamsData {
  final String query;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;

  const SearchCFParamsData({required this.query, required this.pageNo});

  Map<String, dynamic> toJson() => _$SearchCFParamsDataToJson(this);
}
