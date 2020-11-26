import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TrendingSearchState extends Equatable {
  const TrendingSearchState();

  @override
  List<Object> get props => [];
}

class TrendingSearchesLoading extends TrendingSearchState {}

class TrendingSearchesLoaded extends TrendingSearchState {
  final List<String> trendingSearches;

  const TrendingSearchesLoaded({@required this.trendingSearches});

  @override
  List<Object> get props => [trendingSearches];
}

class TrendingSearchesLoadingError extends TrendingSearchState {
  final dynamic error;

  const TrendingSearchesLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
