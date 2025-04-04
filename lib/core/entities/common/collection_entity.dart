import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class CollectionEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;

  CollectionEntity(
      {required this.id,
      required this.name,
      this.posterPath,
      this.backdropPath});

  @override
  List<Object?> get props => [id, name, posterPath, backdropPath];
}
