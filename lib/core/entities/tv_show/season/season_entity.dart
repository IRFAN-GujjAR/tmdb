import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';

class SeasonEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.seasonNo)
  final int seasonNo;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;

  SeasonEntity(
      {required this.id,
      required this.seasonNo,
      required this.name,
      this.posterPath});

  @override
  List<Object?> get props => [id, seasonNo, name, posterPath];
}
