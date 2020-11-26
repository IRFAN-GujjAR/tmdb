import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/rated_model.dart';

class RatedState extends Equatable {
  const RatedState();

  @override
  List<Object> get props => [];
}

class RatedLoading extends RatedState {}

class RatedLoaded extends RatedState {
  final RatedModel rated;

  const RatedLoaded({@required this.rated});

  @override
  List<Object> get props => [rated];
}

class RatedEmpty extends RatedState {}

class RatedLoadingError extends RatedState {
  final dynamic error;

  const RatedLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
