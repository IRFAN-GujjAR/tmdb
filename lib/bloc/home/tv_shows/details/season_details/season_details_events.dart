import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SeasonDetailsEvent extends Equatable {
  const SeasonDetailsEvent();

  @override
  List<Object> get props => [];
}

class LoadSeasonDetails extends SeasonDetailsEvent {
  final int id;
  final int seasonNumber;

  const LoadSeasonDetails({@required this.id, @required this.seasonNumber});

  @override
  List<Object> get props => [id, seasonNumber];
}
