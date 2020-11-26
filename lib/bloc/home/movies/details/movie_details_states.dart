import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/details/movie_details_data.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsData movieDetailsData;

  const MovieDetailsLoaded({@required this.movieDetailsData});

  @override
  List<Object> get props => [movieDetailsData];
}

class MovieDetailsLoadingError extends MovieDetailsState {
  final dynamic error;

  const MovieDetailsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
