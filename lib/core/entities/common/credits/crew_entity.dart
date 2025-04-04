import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';

class CrewEntity {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.job)
  final String? job;
  @JsonKey(name: JsonKeysNames.department)
  final String? department;
  @JsonKey(name: JsonKeysNames.profilePath)
  final String? profilePath;

  CrewEntity(
      {required this.id,
      required this.name,
      this.job,
      this.department,
      this.profilePath});
}
