import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/credits/cast_entity.dart';

part 'cast_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CastModel extends CastEntity {
  CastModel(
      {required super.id,
      required super.character,
      required super.name,
      super.gender,
      super.order,
      super.profilePath});

  factory CastModel.fromJson(Map<String, dynamic> json) =>
      _$CastModelFromJson(json);
}
