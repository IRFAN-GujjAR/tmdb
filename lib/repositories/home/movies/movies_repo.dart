import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class MoviesRepo extends BaseRepo {
  MoviesRepo({@required Client client}) : super(client);

  Future<List<MoviesList>> get loadMoviesLists async {
    final popular = await MovieUtilsRepo.getCategoryMovies(
        client: client, url: URLS.popularMovies(1));
    final inTheatres = await MovieUtilsRepo.getCategoryMovies(
        client: client, url: URLS.inTheatresMovies(1));
    final trending = await MovieUtilsRepo.getCategoryMovies(
        client: client, url: URLS.trendingMovies(1));
    final topRated = await MovieUtilsRepo.getCategoryMovies(
        client: client, url: URLS.topRatedMovies(1));
    final upcoming = await MovieUtilsRepo.getCategoryMovies(
        client: client, url: URLS.upComingMovies(1));
    List<MoviesData> deleteMovies = [];
    upcoming.movies.forEach((movie) {
      if (movie.releaseDate != null) {
        int year, month, day;
        year = int.parse(movie.releaseDate.substring(0, 4));
        month = int.parse(movie.releaseDate.substring(5, 7));
        day = int.parse(movie.releaseDate.substring(8, 10));

        if (DateTime.now().year == year) {
          if (DateTime.now().month == month) {
            if (DateTime.now().day > day) deleteMovies.add(movie);
          } else if (DateTime.now().month > month) {
            deleteMovies.add(movie);
          }
        } else if (DateTime.now().year > year) {
          deleteMovies.add(movie);
        }
      }
    });

    if (deleteMovies.isNotEmpty) {
      deleteMovies.forEach((movie) {
        upcoming.movies.remove(movie);
      });
    }

    MoviesList newUpComing = upcoming;

    if (newUpComing != null) {
      int counter = 2;
      while (newUpComing.movies.length < 20) {
        final s = await MovieUtilsRepo.getCategoryMovies(
            client: client, url: URLS.upComingMovies(counter));
        newUpComing = MoviesList(
            pageNumber: s.pageNumber,
            totalPages: s.totalPages,
            movies: newUpComing.movies);
        newUpComing.movies.addAll(s.movies);
        counter++;
      }
    }

    return [popular, inTheatres, trending, topRated, newUpComing];
  }
}
