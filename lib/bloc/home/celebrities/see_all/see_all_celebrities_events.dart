import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/models/celebrities_list.dart';

class SeeAllCelebritiesEvent extends Equatable {
  const SeeAllCelebritiesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreSeeAllCelebrities extends SeeAllCelebritiesEvent {
  final CelebritiesList previousCelebrities;
  final String url;

  const LoadMoreSeeAllCelebrities(
      {@required this.previousCelebrities, @required this.url});

  @override
  List<Object> get props => [previousCelebrities, url];
}
