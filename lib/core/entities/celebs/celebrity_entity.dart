import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class CelebrityEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.knownForDept)
  final String? knownFor;
  @JsonKey(name: JsonKeysNames.profilePath)
  final String? profilePath;

  CelebrityEntity(
      {required this.id, required this.name, this.knownFor, this.profilePath});

  @override
  List<Object?> get props => [id, name, knownFor, profilePath];
}
