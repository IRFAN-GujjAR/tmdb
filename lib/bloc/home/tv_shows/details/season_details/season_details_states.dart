import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/details/season_details_data.dart';

class SeasonDetailsState extends Equatable {
  const SeasonDetailsState();

  @override
  List<Object> get props => [];
}

class SeasonDetailsLoading extends SeasonDetailsState {}

class SeasonDetailsLoaded extends SeasonDetailsState {
  final SeasonDetailsData seasonDetailsData;

  const SeasonDetailsLoaded({@required this.seasonDetailsData});

  @override
  List<Object> get props => [seasonDetailsData];
}

class SeasonDetailsLoadingError extends SeasonDetailsState {
  final dynamic error;

  const SeasonDetailsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
