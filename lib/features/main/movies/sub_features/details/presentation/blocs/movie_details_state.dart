part of 'movie_details_bloc.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();
}

final class MovieDetailsStateInitial extends MovieDetailsState {
  @override
  List<Object> get props => [];
}

final class MovieDetailsStateLoading extends MovieDetailsState {
  @override
  List<Object?> get props => [];
}

final class MovieDetailsStateLoaded extends MovieDetailsState {
  final MovieDetailsEntity movieDetails;

  MovieDetailsStateLoaded(this.movieDetails);

  @override
  List<Object?> get props => [movieDetails];
}

final class MovieDetailsStateError extends MovieDetailsState {
  final CustomErrorEntity error;

  MovieDetailsStateError(this.error);

  @override
  List<Object?> get props => [error];
}
