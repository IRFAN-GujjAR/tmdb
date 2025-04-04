import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/api/utils/json_keys_names.dart';

class RatedEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.value)
  final double value;

  RatedEntity({required this.value});

  @override
  List<Object?> get props => [value];
}
