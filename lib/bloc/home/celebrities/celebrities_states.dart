import 'package:flutter/material.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';

class CelebritiesState {
  const CelebritiesState();
}

class CelebritiesLoading extends CelebritiesState {}

class CelebritiesLoaded extends CelebritiesState {
  final List<CelebritiesList> celebritiesLists;
  final List<CelebritiesData> firstHalfPopular;
  final List<CelebritiesData> secondHalfPopular;

  const CelebritiesLoaded(
      {@required this.celebritiesLists,
      @required this.firstHalfPopular,
      @required this.secondHalfPopular});
}

class CelebritiesLoadingError extends CelebritiesState {
  final dynamic error;

  const CelebritiesLoadingError({@required this.error});
}
