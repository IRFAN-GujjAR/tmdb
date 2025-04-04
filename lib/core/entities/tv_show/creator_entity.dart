import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class CreatorEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.name)
  final String name;

  CreatorEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
