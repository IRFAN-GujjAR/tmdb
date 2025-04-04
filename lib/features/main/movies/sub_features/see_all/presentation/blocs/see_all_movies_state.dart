part of 'see_all_movies_bloc.dart';

sealed class SeeAllMoviesState extends Equatable {
  const SeeAllMoviesState();
}

final class SeeAllMoviesStateInitial extends SeeAllMoviesState {
  @override
  List<Object> get props => [];
}

final class SeeAllMoviesStateLoading extends SeeAllMoviesState {
  @override
  List<Object> get props => [];
}

final class SeeAllMoviesStateLoaded extends SeeAllMoviesState {
  final MoviesListEntity moviesList;

  SeeAllMoviesStateLoaded(this.moviesList);

  @override
  List<Object> get props => [moviesList];
}

final class SeeAllMoviesStateError extends SeeAllMoviesState {
  final CustomErrorEntity error;

  SeeAllMoviesStateError({required this.error});

  @override
  List<Object> get props => [error];
}
