import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';

class TvShowDetailsState extends Equatable {
  const TvShowDetailsState();

  @override
  List<Object> get props => [];
}

class TvShowDetailsLoading extends TvShowDetailsState {}

class TvShowDetailsLoaded extends TvShowDetailsState {
  final TvShowDetailsData tvShowDetails;

  const TvShowDetailsLoaded({@required this.tvShowDetails});

  @override
  List<Object> get props => [tvShowDetails];
}

class TvShowDetailsLoadingError extends TvShowDetailsState {
  final dynamic error;

  const TvShowDetailsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
