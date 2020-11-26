import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/watchlist_model.dart';

class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

class WatchListLoading extends WatchListState {}

class WatchListLoaded extends WatchListState {
  final WatchListModel watchList;

  const WatchListLoaded({@required this.watchList});

  @override
  List<Object> get props => [watchList];
}

class WatchListEmpty extends WatchListState {}

class WatchListLoadingError extends WatchListState {
  final dynamic error;

  const WatchListLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
