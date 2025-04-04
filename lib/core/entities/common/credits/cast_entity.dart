import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';

class CastEntity {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.character)
  final String character;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.gender)
  final int? gender;
  @JsonKey(name: JsonKeysNames.order)
  final int? order;
  @JsonKey(name: JsonKeysNames.profilePath)
  final String? profilePath;

  CastEntity(
      {required this.id,
      required this.character,
      required this.name,
      this.gender,
      this.order,
      this.profilePath});
}
