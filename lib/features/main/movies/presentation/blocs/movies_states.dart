import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/movies/domain/entities/movies_entity.dart';

import '../../../../../core/entities/error/custom_error_entity.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();
}

final class MoviesStateLoading extends MoviesState {
  @override
  List<Object?> get props => [];
}

final class MoviesStateLoaded extends MoviesState {
  final MoviesEntity movies;

  const MoviesStateLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class MoviesStateErrorWithCache extends MoviesState {
  final MoviesEntity movies;
  final CustomErrorEntity error;

  const MoviesStateErrorWithCache({required this.movies, required this.error});

  @override
  List<Object> get props => [movies, error];
}

final class MoviesStateErrorWithoutCache extends MoviesState {
  final CustomErrorEntity error;

  const MoviesStateErrorWithoutCache({required this.error});

  @override
  List<Object> get props => [error];
}
