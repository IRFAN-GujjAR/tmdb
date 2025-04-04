import 'package:equatable/equatable.dart';

import 'movie_entity.dart';

class MoviesListEntity extends Equatable {
  final int pageNo;
  final int totalPages;
  final List<MovieEntity> movies;

  MoviesListEntity(
      {required this.pageNo, required this.totalPages, required this.movies});

  @override
  List<Object?> get props => [pageNo, totalPages, movies];
}
