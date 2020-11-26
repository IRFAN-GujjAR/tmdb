import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/favourite_model.dart';

class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final FavouriteModel favourites;

  const FavouriteLoaded({@required this.favourites});

  @override
  List<Object> get props => [favourites];
}

class FavouriteEmpty extends FavouriteState {}

class FavouriteLoadingError extends FavouriteState {
  final dynamic error;

  const FavouriteLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
