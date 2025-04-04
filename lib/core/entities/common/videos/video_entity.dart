import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';

class VideoEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.key)
  final String key;
  @JsonKey(name: JsonKeysNames.name)
  final String name;

  VideoEntity({required this.key, required this.name});

  @override
  List<Object?> get props => [key, name];
}
