part of 'movie_details_bloc.dart';

sealed class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();
}

final class MovieDetailsEventLoad extends MovieDetailsEvent {
  final int movieId;

  MovieDetailsEventLoad(this.movieId);

  @override
  List<Object?> get props => [movieId];
}
