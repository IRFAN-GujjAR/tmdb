import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class TvShowDetailsEvent extends Equatable {
  const TvShowDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadTvShowDetails extends TvShowDetailsEvent {
  final int tvId;

  const LoadTvShowDetails({@required this.tvId});

  @override
  List<Object> get props => [tvId];
}
