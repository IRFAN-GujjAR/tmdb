import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/details/movie_details_events.dart';
import 'package:tmdb/bloc/home/movies/details/movie_details_states.dart';
import 'package:tmdb/repositories/home/movies/movie_details/movie_details_repo.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepo _movieDetailsRepo;

  MovieDetailsBloc({@required MovieDetailsRepo movieDetailsRepo})
      : _movieDetailsRepo = movieDetailsRepo,
        super(MovieDetailsState());

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    if (event is LoadMovieDetails) {
      yield* _loadMovieDetails(event);
    }
  }

  Stream<MovieDetailsState> _loadMovieDetails(LoadMovieDetails event) async* {
    yield MovieDetailsLoading();
    try {
      final movieDetails =
          await _movieDetailsRepo.loadMovieDetails(event.movieId);
      yield MovieDetailsLoaded(movieDetailsData: movieDetails);
    } catch (error) {
      yield MovieDetailsLoadingError(error: error);
    }
  }
}
