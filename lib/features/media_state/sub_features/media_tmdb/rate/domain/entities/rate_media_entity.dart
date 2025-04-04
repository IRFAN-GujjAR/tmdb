import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

class RateMediaEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.value)
  final int rating;

  RateMediaEntity({required this.rating});

  @override
  List<Object?> get props => [rating];
}
