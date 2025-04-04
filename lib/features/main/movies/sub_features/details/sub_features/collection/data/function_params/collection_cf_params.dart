import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/data/function_params/collection_cf_params_data.dart';

part 'collection_cf_params.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class CollectionCFParams {
  final MoviesCFCategory category;
  @JsonKey(name: CFJsonKeys.PARAMS_DATA)
  final CollectionCFParamsData data;

  const CollectionCFParams({required this.category, required this.data});

  Map<String, dynamic> toJson() => _$CollectionCFParamsToJson(this);
}
