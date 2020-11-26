import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class MultiSearchEvent extends Equatable {
  const MultiSearchEvent();

  @override
  List<Object> get props => [];
}

class SearchMultiSearch extends MultiSearchEvent {
  final String query;

  const SearchMultiSearch({@required this.query});

  @override
  List<Object> get props => [query];
}
