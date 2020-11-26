import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_list.dart';

class SeeAllMoviesState extends Equatable {
  const SeeAllMoviesState();

  @override
  List<Object> get props => [];
}

class SeeAllMoviesLoadingMore extends SeeAllMoviesState {
  final MoviesList movies;

  const SeeAllMoviesLoadingMore({@required this.movies});

  @override
  List<Object> get props => [movies];
}

class SeeAllMoviesLoaded extends SeeAllMoviesState {
  final MoviesList movies;

  const SeeAllMoviesLoaded({@required this.movies});

  @override
  List<Object> get props => [movies];
}

class SeeAllMoviesError extends SeeAllMoviesState {
  final MoviesList movies;
  final dynamic error;

  const SeeAllMoviesError({@required this.movies, @required this.error});

  @override
  List<Object> get props => [movies, error];
}
