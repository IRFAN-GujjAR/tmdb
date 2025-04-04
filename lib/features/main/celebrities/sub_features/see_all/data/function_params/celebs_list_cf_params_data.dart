import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_list_cf_category.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'celebs_list_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class CelebsListCFParamsData {
  @JsonKey(name: CFJsonKeys.LIST_CATEGORY)
  final CelebsListCFCategory listCategory;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;

  const CelebsListCFParamsData({
    required this.listCategory,
    required this.pageNo,
  });

  Map<String, dynamic> toJson() => _$CelebsListCFParamsDataToJson(this);
}
