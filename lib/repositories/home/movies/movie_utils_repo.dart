import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/api_provider.dart';

class MovieUtilsRepo {
  static Future<MoviesList> getCategoryMovies(
      {@required Client client, @required String url}) async {
    try {
      final json = await ApiProvider.get(url: url, httpClient: client);
      final movies = MoviesList.fromJson(json);
      return getCorrectMovies(movies);
    } catch (error) {
      throw error;
    }
  }

  static MoviesList getCorrectMovies(MoviesList movies) {
    if (movies == null || movies.movies.isEmpty) {
      return MoviesList(
          pageNumber: movies.pageNumber,
          totalPages: movies.totalPages,
          movies: []);
    }

    List<MoviesData> deleteMovies;

    movies.movies.forEach((movie) {
      if (movie.posterPath == null || movie.backdropPath == null) {
        deleteMovies == null ? deleteMovies = [movie] : deleteMovies.add(movie);
      }
    });

    if (deleteMovies != null && deleteMovies.isNotEmpty) {
      deleteMovies.forEach((movie) {
        movies.movies.remove(movie);
      });
    }

    return movies;
  }
}
