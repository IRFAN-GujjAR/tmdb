import 'package:equatable/equatable.dart';

import '../../../../../../../../../core/entities/movie/movie_entity.dart';

final class MovieCollectionDetailsEntity extends Equatable {
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final List<MovieEntity> movies;

  MovieCollectionDetailsEntity(
      {required this.name,
      required this.overview,
      required this.posterPath,
      required this.backdropPath,
      required this.movies});

  @override
  List<Object?> get props => [name, overview, posterPath, backdropPath, movies];
}
