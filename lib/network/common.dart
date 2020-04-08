import 'dart:convert';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';

Future<MoviesList> convertMoviesResponse(String responseBody) async {
  final parsed = json.decode(responseBody)['results'];
  final totalPages = json.decode(responseBody)['total_pages'] as int;
  final pageNumber = json.decode(responseBody)['page'] as int;
  if (totalPages == 0 || parsed == null) {
    return MoviesList(
        pageNumber: pageNumber, totalPages: totalPages, movies: []);
  }

  final List<MoviesData> movies =
      parsed.map<MoviesData>((json) => MoviesData.fromJson(json)).toList();

  return MoviesList(
      pageNumber: pageNumber, totalPages: totalPages, movies: movies);
}

MoviesList getCorrectMovies(MoviesList movies) {
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

Future<TvShowsList> convertTvShowsResponse(String responseBody) async {
  final totalPages = json.decode(responseBody)['total_pages'] as int;
  final pageNumber = json.decode(responseBody)['page'] as int;
  final parsed = json.decode(responseBody)['results'];
  if (totalPages == 0 || parsed == null) {
    return TvShowsList(
        pageNumber: pageNumber, totalPages: totalPages, tvShows: []);
  }

  final List<TvShowsData> tvShows =
      parsed.map<TvShowsData>((json) => TvShowsData.fromJson(json)).toList();

  return TvShowsList(
      pageNumber: pageNumber, totalPages: totalPages, tvShows: tvShows);
}

TvShowsList getCorrectTvShows(TvShowsList tvShowsList) {
  if (tvShowsList == null || tvShowsList.tvShows.isEmpty) {
    return TvShowsList(
        pageNumber: tvShowsList.pageNumber,
        totalPages: tvShowsList.totalPages,
        tvShows: []);
  }

  List<TvShowsData> deleteTvShows;

  tvShowsList.tvShows.forEach((tvShow) {
    if (tvShow.posterPath == null || tvShow.backdropPath == null) {
      deleteTvShows == null
          ? deleteTvShows = [tvShow]
          : deleteTvShows.add(tvShow);
    }
  });

  if (deleteTvShows != null && deleteTvShows.isNotEmpty) {
    deleteTvShows.forEach((movie) {
      tvShowsList.tvShows.remove(movie);
    });
  }

  return tvShowsList;
}

Future<CelebritiesList> convertCelebritiesResponse(String responseBody) async {
  final totalPages = json.decode(responseBody)['total_pages'] as int;
  final pageNumber = json.decode(responseBody)['page'] as int;
  final parsed = json.decode(responseBody)['results'];
  if (totalPages == 0 || parsed == null) {
    return CelebritiesList(
        pageNumber: pageNumber, totalPages: totalPages, celebrities: []);
  }
  final List<CelebritiesData> celebrities = parsed
      .map<CelebritiesData>((json) => CelebritiesData.fromJson(json))
      .toList();

  final List<CelebritiesData> correctedCelebrities =
      _getCorrectedCelebrities(celebrities);

  return CelebritiesList(
      pageNumber: pageNumber,
      totalPages: totalPages,
      celebrities: correctedCelebrities);
}

List<CelebritiesData> _getCorrectedCelebrities(
    List<CelebritiesData> celebrities) {
  List<CelebritiesData> deletingCelebrities;

  celebrities.forEach((celeb) {
    if (celeb.profilePath == null || celeb.knownFor == null) {
      deletingCelebrities == null
          ? deletingCelebrities = [celeb]
          : deletingCelebrities.add(celeb);
    }
  });

  if (deletingCelebrities != null) {
    deletingCelebrities.forEach((celeb) {
      celebrities.remove(celeb);
    });
  }

  return celebrities;
}
