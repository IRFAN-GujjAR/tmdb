import 'package:flutter/material.dart';

import 'movies_data.dart';

class MoviesList {
  final int pageNumber;
  final int totalPages;
  final List<MoviesData> movies;

  MoviesList(
      {@required this.pageNumber,
      @required this.totalPages,
      @required this.movies});

  factory MoviesList.fromJson(Map<String, dynamic> json) => MoviesList(
      pageNumber: json['page'],
      totalPages: json['total_pages'],
      movies: json['results']
          .map<MoviesData>((json) => MoviesData.fromJson(json))
          .toList());
}
