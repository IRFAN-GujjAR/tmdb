import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/credits/crew_entity.dart';

part 'crew_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CrewModel extends CrewEntity {
  CrewModel(
      {required super.id,
      required super.name,
      super.job,
      super.department,
      super.profilePath});

  factory CrewModel.fromJson(Map<String, dynamic> json) =>
      _$CrewModelFromJson(json);
}
