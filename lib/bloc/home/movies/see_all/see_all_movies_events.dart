import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_list.dart';

class SeeAllMoviesEvent extends Equatable {
  const SeeAllMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreSeeAllMovies extends SeeAllMoviesEvent {
  final MoviesList previousMovies;
  final String url;

  const LoadMoreSeeAllMovies(
      {@required this.previousMovies, @required this.url});

  @override
  List<Object> get props => [previousMovies, url];
}
