import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';

class RatedModel {
  final MoviesList moviesList;
  final TvShowsList tvShowsList;

  const RatedModel({@required this.moviesList, @required this.tvShowsList});

  bool get isMovies => moviesList.movies.isNotEmpty;
  bool get isTvShows => tvShowsList.tvShows.isNotEmpty;
}
