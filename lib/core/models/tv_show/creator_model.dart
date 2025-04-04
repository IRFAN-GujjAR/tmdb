import 'package:json_annotation/json_annotation.dart';

import '../../entities/tv_show/creator_entity.dart';

part 'creator_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class CreatorModel extends CreatorEntity {
  CreatorModel({required super.id, required super.name});

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);
}
