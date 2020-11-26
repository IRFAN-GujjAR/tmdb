import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/details/movie_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class MovieDetailsRepo extends BaseRepo {
  MovieDetailsRepo({@required Client client}) : super(client);

  Future<MovieDetailsData> loadMovieDetails(int movieId) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.movieDetails(movieId), httpClient: client);
      final movieDetails = MovieDetailsData.fromJson(json);

      if (movieDetails.recommendedMovies != null) {
        if (movieDetails.recommendedMovies.movies != null &&
            movieDetails.recommendedMovies.movies.isNotEmpty) {
          List<MoviesData> deleteRecommendedMovies;

          movieDetails.recommendedMovies.movies.forEach((movie) {
            if (movie.posterPath == null || movie.backdropPath == null) {
              deleteRecommendedMovies == null
                  ? deleteRecommendedMovies = [movie]
                  : deleteRecommendedMovies.add(movie);
            }
          });

          if (deleteRecommendedMovies != null &&
              deleteRecommendedMovies.isNotEmpty) {
            deleteRecommendedMovies.forEach((movie) {
              movieDetails.recommendedMovies.movies.remove(movie);
            });
          }
        }
      }

      if (movieDetails.similarMovies != null) {
        if (movieDetails.similarMovies != null &&
            movieDetails.similarMovies.movies.isNotEmpty) {
          List<MoviesData> deleteSimilarMovies;

          movieDetails.similarMovies.movies.forEach((movie) {
            if (movie.posterPath == null || movie.backdropPath == null) {
              deleteSimilarMovies == null
                  ? deleteSimilarMovies = [movie]
                  : deleteSimilarMovies.add(movie);
            }
          });

          if (deleteSimilarMovies != null && deleteSimilarMovies.isNotEmpty) {
            deleteSimilarMovies.forEach((movie) {
              movieDetails.similarMovies.movies.remove(movie);
            });
          }
        }
      }

      return movieDetails;
    } catch (error) {
      throw error;
    }
  }
}
