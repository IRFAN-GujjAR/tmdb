import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetails extends MovieDetailsEvent {
  final int movieId;

  const LoadMovieDetails({@required this.movieId});

  @override
  List<Object> get props => [movieId];
}
