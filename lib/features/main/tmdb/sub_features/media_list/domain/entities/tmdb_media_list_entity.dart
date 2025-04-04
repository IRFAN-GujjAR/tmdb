import 'package:equatable/equatable.dart';

import '../../../../../../../core/entities/movie/movies_list_entity.dart';
import '../../../../../../../core/entities/tv_show/tv_shows_list_entity.dart';

final class TMDbMediaListEntity extends Equatable {
  final MoviesListEntity moviesList;
  final TvShowsListEntity tvShowsList;

  TMDbMediaListEntity({required this.moviesList, required this.tvShowsList});

  bool get isMovies => moviesList.movies.isNotEmpty;
  bool get isTvShows => tvShowsList.tvShows.isNotEmpty;
  bool get isBoth => isMovies && isTvShows;

  @override
  List<Object?> get props => [moviesList, tvShowsList];
}
