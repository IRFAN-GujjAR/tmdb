import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/movies_list.dart';

class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<MoviesList> movies;

  const MoviesLoaded({@required this.movies});

  @override
  List<Object> get props => [movies];
}

class MoviesLoadingError extends MoviesState {
  final dynamic error;

  const MoviesLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
