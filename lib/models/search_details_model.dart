import 'package:flutter/material.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';

class SearchDetailsModel {
  final MoviesList moviesList;
  final TvShowsList tvShowsList;
  final CelebritiesList celebritiesList;

  const SearchDetailsModel(
      {@required this.moviesList,
      @required this.tvShowsList,
      @required this.celebritiesList});

  bool get isMovies => moviesList.movies.isNotEmpty;
  bool get isTvShows => tvShowsList.tvShows.isNotEmpty;
  bool get isCelebrities => celebritiesList.celebrities.isNotEmpty;
}
