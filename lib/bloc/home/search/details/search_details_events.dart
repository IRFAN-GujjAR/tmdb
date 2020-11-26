import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SearchDetailsEvent extends Equatable {
  const SearchDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchDetails extends SearchDetailsEvent {
  final String query;

  const LoadSearchDetails({@required this.query});

  @override
  List<Object> get props => [query];
}
