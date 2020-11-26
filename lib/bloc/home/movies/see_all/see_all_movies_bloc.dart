import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_events.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_states.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/repositories/home/movies/see_all/see_all_movies_repo.dart';

class SeeAllMoviesBloc extends Bloc<SeeAllMoviesEvent, SeeAllMoviesState> {
  final SeeAllMoviesRepo _seeAllMoviesRepo;

  SeeAllMoviesBloc(
      {@required SeeAllMoviesRepo seeAllMoviesRepo,
      @required MoviesList movies})
      : _seeAllMoviesRepo = seeAllMoviesRepo,
        super(SeeAllMoviesLoaded(movies: movies));

  @override
  Stream<SeeAllMoviesState> mapEventToState(SeeAllMoviesEvent event) async* {
    if (event is LoadMoreSeeAllMovies) {
      yield* _loadMoreMovies(event);
    }
  }

  Stream<SeeAllMoviesState> _loadMoreMovies(LoadMoreSeeAllMovies event) async* {
    yield SeeAllMoviesLoadingMore(movies: event.previousMovies);
    try {
      final movies = await _seeAllMoviesRepo.loadMoreMovies(event);
      yield SeeAllMoviesLoaded(movies: movies);
    } catch (error) {
      yield SeeAllMoviesError(movies: event.previousMovies, error: error);
    }
  }

  MoviesList get movies {
    final seeAllMoviesState = state;
    if (seeAllMoviesState is SeeAllMoviesLoaded) {
      return seeAllMoviesState.movies;
    } else if (seeAllMoviesState is SeeAllMoviesLoadingMore) {
      return seeAllMoviesState.movies;
    } else {
      return (seeAllMoviesState as SeeAllMoviesError).movies;
    }
  }
}
