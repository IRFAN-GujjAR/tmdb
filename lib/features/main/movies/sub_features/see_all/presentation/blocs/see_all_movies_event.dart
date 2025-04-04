part of 'see_all_movies_bloc.dart';

sealed class SeeAllMoviesEvent extends Equatable {
  const SeeAllMoviesEvent();
}

final class SeeAllMoviesEventLoad extends SeeAllMoviesEvent {
  final SeeAllMoviesParams params;

  SeeAllMoviesEventLoad({required this.params});

  @override
  List<Object?> get props => [params];
}
