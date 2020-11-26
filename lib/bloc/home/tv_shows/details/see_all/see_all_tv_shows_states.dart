import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/tv_shows_list.dart';

class SeeAllTvShowsState extends Equatable {
  const SeeAllTvShowsState();

  @override
  List<Object> get props => [];
}

class SeeAllTvShowsLoadingMore extends SeeAllTvShowsState {
  final TvShowsList tvShowsList;

  const SeeAllTvShowsLoadingMore({@required this.tvShowsList});

  @override
  List<Object> get props => [tvShowsList];
}

class SeeAllTvShowsLoaded extends SeeAllTvShowsState {
  final TvShowsList tvShowsList;

  const SeeAllTvShowsLoaded({@required this.tvShowsList});

  @override
  List<Object> get props => [tvShowsList];
}

class SeeAllTvShowsError extends SeeAllTvShowsState {
  final TvShowsList tvShowsList;
  final dynamic error;

  const SeeAllTvShowsError({@required this.tvShowsList, @required this.error});

  @override
  List<Object> get props => [tvShowsList, error];
}
