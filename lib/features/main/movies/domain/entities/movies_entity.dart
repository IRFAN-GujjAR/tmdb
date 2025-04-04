import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';

class MoviesEntity extends Equatable {
  final MoviesListEntity popular;
  final MoviesListEntity inTheatres;
  final MoviesListEntity trending;
  final MoviesListEntity topRated;
  final MoviesListEntity upComing;

  MoviesEntity({
    required this.popular,
    required this.inTheatres,
    required this.trending,
    required this.topRated,
    required this.upComing,
  });

  @override
  List<Object?> get props => [
    popular,
    inTheatres,
    trending,
    topRated,
    upComing,
  ];
}
