import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../api/utils/json_keys_names.dart';

class MovieEntity extends Equatable {
  @JsonKey(name: JsonKeysNames.id)
  final int id;
  @JsonKey(name: JsonKeysNames.title)
  final String title;
  @JsonKey(name: JsonKeysNames.genreIds)
  final List<int> genreIds;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;
  @JsonKey(name: JsonKeysNames.voteCount)
  final int voteCount;
  @JsonKey(name: JsonKeysNames.voteAverage)
  final double voteAverage;
  @JsonKey(name: JsonKeysNames.releaseDate)
  final String? releaseDate;

  MovieEntity({
    required this.id,
    required this.title,
    required this.genreIds,
    required this.posterPath,
    required this.backdropPath,
    required this.voteCount,
    required this.voteAverage,
    required this.releaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        genreIds,
        posterPath,
        backdropPath,
        voteCount,
        voteAverage,
        releaseDate
      ];
}
