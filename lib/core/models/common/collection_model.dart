import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/collection_entity.dart';

part 'collection_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CollectionModel extends CollectionEntity {
  CollectionModel(
      {required super.id,
      required super.name,
      super.posterPath,
      super.backdropPath});

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
}
