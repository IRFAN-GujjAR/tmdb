import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/search_details_model.dart';

class SearchDetailsState extends Equatable {
  const SearchDetailsState();

  @override
  List<Object> get props => [];
}

class SearchDetailsLoading extends SearchDetailsState {}

class SearchDetailsLoaded extends SearchDetailsState {
  final SearchDetailsModel searchDetails;

  const SearchDetailsLoaded({@required this.searchDetails});

  @override
  List<Object> get props => [searchDetails];
}

class SearchDetailsEmpty extends SearchDetailsState {}

class SearchDetailsLoadingError extends SearchDetailsState {
  final dynamic error;

  const SearchDetailsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
