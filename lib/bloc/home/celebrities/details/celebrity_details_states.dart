import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/details/celebrities_details_data.dart';

class CelebrityDetailsState extends Equatable {
  const CelebrityDetailsState();

  @override
  List<Object> get props => [];
}

class CelebrityDetailsLoading extends CelebrityDetailsState {}

class CelebrityDetailsLoaded extends CelebrityDetailsState {
  final CelebritiesDetailsData celebritiesDetails;

  const CelebrityDetailsLoaded({@required this.celebritiesDetails});

  @override
  List<Object> get props => [celebritiesDetails];
}

class CelebrityDetailsLoadingError extends CelebrityDetailsState {
  final dynamic error;

  const CelebrityDetailsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
