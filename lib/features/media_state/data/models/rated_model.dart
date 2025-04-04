import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/domain/entities/rated_entity.dart';

part 'rated_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class RatedModel extends RatedEntity {
  RatedModel({required super.value});

  factory RatedModel.fromJson(Map<String, dynamic> json) =>
      _$RatedModelFromJson(json);
}
