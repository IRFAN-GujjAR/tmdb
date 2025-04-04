import 'package:json_annotation/json_annotation.dart';

part 'collection_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class CollectionCFParamsData {
  @JsonKey(name: 'collection_id')
  final int collectionId;

  const CollectionCFParamsData(this.collectionId);

  Map<String, dynamic> toJson() => _$CollectionCFParamsDataToJson(this);
}
