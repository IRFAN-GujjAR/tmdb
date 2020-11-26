import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/celebrities_list.dart';

class SeeAllCelebritiesState extends Equatable {
  const SeeAllCelebritiesState();

  @override
  List<Object> get props => [];
}

class SeeAllCelebritiesLoadingMore extends SeeAllCelebritiesState {
  final CelebritiesList celebrities;

  const SeeAllCelebritiesLoadingMore({@required this.celebrities});

  @override
  List<Object> get props => [celebrities];
}

class SeeAllCelebritiesLoaded extends SeeAllCelebritiesState {
  final CelebritiesList celebrities;

  const SeeAllCelebritiesLoaded({@required this.celebrities});

  @override
  List<Object> get props => [celebrities];
}

class SeeAllCelebritiesError extends SeeAllCelebritiesState {
  final CelebritiesList celebrities;
  final dynamic error;

  const SeeAllCelebritiesError(
      {@required this.celebrities, @required this.error});

  @override
  List<Object> get props => [celebrities, error];
}
