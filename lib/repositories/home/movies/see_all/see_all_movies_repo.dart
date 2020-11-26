import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_events.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';

class SeeAllMoviesRepo extends BaseRepo {
  SeeAllMoviesRepo({@required Client client}) : super(client);

  Future<MoviesList> loadMoreMovies(LoadMoreSeeAllMovies event) async {
    try {
      final newMovies = await MovieUtilsRepo.getCategoryMovies(
          client: client, url: event.url);
      return MoviesList(
          pageNumber: newMovies.pageNumber,
          totalPages: newMovies.totalPages,
          movies: event.previousMovies.movies + newMovies.movies);
    } catch (error) {
      throw error;
    }
  }
}
