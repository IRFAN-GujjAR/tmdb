import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';

class BackdropImageEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.filePath)
  final String filePath;

  const BackdropImageEntity({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}
