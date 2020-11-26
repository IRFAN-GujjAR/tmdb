import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MultiSearchState extends Equatable {
  const MultiSearchState();

  @override
  List<Object> get props => [];
}

class MultiSearchLoading extends MultiSearchState {}

class MultiSearchLoaded extends MultiSearchState {
  final List<String> searches;

  const MultiSearchLoaded({@required this.searches});

  @override
  List<Object> get props => [searches];
}

class MultiSearchLoadingError extends MultiSearchState {
  final dynamic error;

  const MultiSearchLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}
