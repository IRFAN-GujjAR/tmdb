import 'package:json_annotation/json_annotation.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_details_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class SearchDetailsCFParamsData {
  final String query;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;

  const SearchDetailsCFParamsData({required this.query, required this.pageNo});

  Map<String, dynamic> toJson() => _$SearchDetailsCFParamsDataToJson(this);
}
