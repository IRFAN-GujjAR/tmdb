import 'package:json_annotation/json_annotation.dart';

import '../../entities/movie/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
final class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.title,
    required super.genreIds,
    required super.posterPath,
    required super.backdropPath,
    required super.voteCount,
    required super.voteAverage,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);
}
