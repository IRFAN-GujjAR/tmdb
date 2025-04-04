import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class TvShowEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.genreIds)
  final List<int> genreIds;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;
  @JsonKey(name: JsonKeysNames.voteAverage)
  final double voteAverage;
  @JsonKey(name: JsonKeysNames.voteCount)
  final int voteCount;

  TvShowEntity({
    required this.id,
    required this.name,
    required this.genreIds,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props =>
      [id, name, genreIds, posterPath, backdropPath, voteCount, voteAverage];
}
