import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class GenreEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;

  GenreEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
