import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';

final class SearchDetailsEntity extends Equatable {
  final MoviesListEntity moviesList;
  final TvShowsListEntity tvShowsList;
  final CelebritiesListEntity celebritiesList;

  SearchDetailsEntity(
      {required this.moviesList,
      required this.tvShowsList,
      required this.celebritiesList});

  bool get isAll => isMovies && isTvShows && isCelebrities;
  bool get isMovies => moviesList.movies.isNotEmpty;
  bool get isTvShows => tvShowsList.tvShows.isNotEmpty;
  bool get isCelebrities => celebritiesList.celebrities.isNotEmpty;

  @override
  List<Object?> get props => [moviesList, tvShowsList, celebritiesList];
}
