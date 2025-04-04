import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';

part 'celebs_cf_params.g.dart';

@JsonSerializable(createFactory: false)
final class CelebsCFParams {
  final CelebsCFCategory category;

  const CelebsCFParams({required this.category});

  Map<String, dynamic> toJson() => _$CelebsCFParamsToJson(this);
}
