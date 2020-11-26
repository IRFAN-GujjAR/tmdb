import 'package:flutter/material.dart';
import 'package:tmdb/models/tv_shows_list.dart';

class TvShowsState {
  const TvShowsState();
}

class TvShowsLoading extends TvShowsState {}

class TvShowsLoaded extends TvShowsState {
  final List<TvShowsList> tvshowsLists;

  const TvShowsLoaded({@required this.tvshowsLists});
}

class TvShowsLoadingError extends TvShowsState {
  final dynamic error;

  const TvShowsLoadingError({@required this.error});
}
