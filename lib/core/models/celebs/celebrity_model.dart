import 'package:json_annotation/json_annotation.dart';

import '../../entities/celebs/celebrity_entity.dart';

part 'celebrity_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
final class CelebrityModel extends CelebrityEntity {
  CelebrityModel({
    required super.id,
    required super.name,
    super.knownFor,
    super.profilePath,
  });

  factory CelebrityModel.fromJson(Map<String, dynamic> json) =>
      _$CelebrityModelFromJson(json);
  Map<String, dynamic> toJson() => _$CelebrityModelToJson(this);
}
