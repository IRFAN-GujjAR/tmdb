import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/api/utils/json_keys_names.dart';
import 'package:tmdb/core/models/movie/movie_model.dart';

part 'movie_collection_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class MovieCollectionDetailsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.overview)
  final String overview;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;
  @JsonKey(name: JsonKeysNames.movieCollectionMovies)
  final List<MovieModel> movies;

  MovieCollectionDetailsModel(
      {required this.name,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.movies});

  factory MovieCollectionDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieCollectionDetailsModelFromJson(json);

  @override
  List<Object?> get props => [name, overview, posterPath, backdropPath, movies];
}
