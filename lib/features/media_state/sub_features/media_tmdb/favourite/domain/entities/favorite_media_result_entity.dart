import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

class FavoriteMediaResultEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.statusCode)
  final int? statusCode;
  @JsonKey(name: JsonKeysNames.statusMessage)
  final String? statusMessage;

  const FavoriteMediaResultEntity(
      {required this.statusCode, required this.statusMessage});

  @override
  List<Object?> get props => [statusCode, statusMessage];
}
