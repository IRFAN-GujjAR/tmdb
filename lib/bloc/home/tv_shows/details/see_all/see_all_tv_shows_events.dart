import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/tv_shows_list.dart';

class SeeAllTvShowsEvent extends Equatable {
  const SeeAllTvShowsEvent();
  @override
  List<Object> get props => [];
}

class LoadMoreSeeAllTvShows extends SeeAllTvShowsEvent {
  final TvShowsList previousTvShows;
  final String url;

  const LoadMoreSeeAllTvShows(
      {@required this.previousTvShows, @required this.url});

  @override
  List<Object> get props => [previousTvShows, url];
}
