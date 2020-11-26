import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/movies_events.dart';
import 'package:tmdb/bloc/home/movies/movies_states.dart';
import 'package:tmdb/repositories/home/movies/movies_repo.dart';

class MoviesBloc extends Bloc<MoviesEvents, MoviesState> {
  final MoviesRepo _moviesRepo;

  MoviesBloc({@required MoviesRepo moviesRepo})
      : _moviesRepo = moviesRepo,
        super(MoviesState());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvents event) async* {
    switch (event) {
      case MoviesEvents.Load:
        yield* _loadMovies;
        break;
    }
  }

  Stream<MoviesState> get _loadMovies async* {
    yield MoviesLoading();
    try {
      final movies = await _moviesRepo.loadMoviesLists;
      yield MoviesLoaded(movies: movies);
    } catch (error) {
      yield MoviesLoadingError(error: error);
    }
  }
}
