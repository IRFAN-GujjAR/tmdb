import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/models/details/celebrities_details_data.dart';
import 'package:tmdb/models/details/movie_details_data.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/utils/utils.dart';


Future<MovieDetailsData> fetchMovieDetails(
    http.Client client, int movieId) async {
  final movieDetailsUrl =
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$Api_Key&language=en-US&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  var detailsResponse;
  try {
    detailsResponse = await client
        .get(movieDetailsUrl)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final parsed = json.decode(detailsResponse.body);

  MovieDetailsData movieDetails = MovieDetailsData.fromJson(parsed);

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
}

Future<TvShowDetailsData> fetchTvShowDetails(
    http.Client client, int tvShowId) async {
  final tvDetailsUrl =
      'https://api.themoviedb.org/3/tv/$tvShowId?api_key=$Api_Key&language=en-US&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  var detailsResponse;
  try {
    detailsResponse = await client
        .get(tvDetailsUrl)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final parsed = json.decode(detailsResponse.body);

  TvShowDetailsData tvShowDetails = TvShowDetailsData.fromJson(parsed);

  if (tvShowDetails.recommendedTvShows != null) {
    if (tvShowDetails.recommendedTvShows.tvShows != null &&
        tvShowDetails.recommendedTvShows.tvShows.isNotEmpty) {
      List<TvShowsData> deleteRecommendedTvShows;

      tvShowDetails.recommendedTvShows.tvShows.forEach((tvShow) {
        if (tvShow.posterPath == null || tvShow.backdropPath == null) {
          deleteRecommendedTvShows == null
              ? deleteRecommendedTvShows = [tvShow]
              : deleteRecommendedTvShows.add(tvShow);
        }
      });

      if (deleteRecommendedTvShows != null &&
          deleteRecommendedTvShows.isNotEmpty) {
        deleteRecommendedTvShows.forEach((tvShow) {
          tvShowDetails.recommendedTvShows.tvShows.remove(tvShow);
        });
      }
    }
  }

  if (tvShowDetails.similarTvShows != null) {
    if (tvShowDetails.similarTvShows.tvShows != null &&
        tvShowDetails.similarTvShows.tvShows.isNotEmpty) {
      List<TvShowsData> deleteSimilarTvShows;

      tvShowDetails.similarTvShows.tvShows.forEach((tvShow) {
        if (tvShow.posterPath == null || tvShow.backdropPath == null) {
          deleteSimilarTvShows == null
              ? deleteSimilarTvShows = [tvShow]
              : deleteSimilarTvShows.add(tvShow);
        }
      });

      if (deleteSimilarTvShows != null && deleteSimilarTvShows.isNotEmpty) {
        deleteSimilarTvShows.forEach((tvShow) {
          tvShowDetails.similarTvShows.tvShows.remove(tvShow);
        });
      }
    }
  }

  if (tvShowDetails.seasons != null && tvShowDetails.seasons.isNotEmpty) {
    if (tvShowDetails.seasons[0].seasonNumber == 0) {
      tvShowDetails.seasons.removeAt(0);
    }

    List<Season> deleteSeason;

    tvShowDetails.seasons.forEach((season) {
      if (season.posterPath == null) {
        deleteSeason == null
            ? deleteSeason = [season]
            : deleteSeason.add(season);
      }
    });

    if (deleteSeason != null && deleteSeason.isNotEmpty) {
      deleteSeason.forEach((season) {
        tvShowDetails.seasons.remove(season);
      });
    }
  }

  return tvShowDetails;
}

Future<CelebritiesDetailsData> fetCelebrityDetails(
    http.Client client, int celebId) async {
  final celebrityDetailsUrl =
      'https://api.themoviedb.org/3/person/$celebId?api_key=$Api_Key&language=en-US&append_to_response=movie_credits%2Ctv_credits';

  var detailsResponse;
  try {
    detailsResponse = await client
        .get(celebrityDetailsUrl)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final parsed = json.decode(detailsResponse.body);

  CelebritiesDetailsData celebritiesDetails =
      CelebritiesDetailsData.fromJson(parsed);

  if (celebritiesDetails.movieCredits != null) {
    if (celebritiesDetails.movieCredits.cast != null &&
        celebritiesDetails.movieCredits.cast.isNotEmpty) {
      List<MoviesData> deleteMoviesCast;

      celebritiesDetails.movieCredits.cast.forEach((movie) {
        if (movie.backdropPath == null || movie.posterPath == null) {
          deleteMoviesCast == null
              ? deleteMoviesCast = [movie]
              : deleteMoviesCast.add(movie);
        }
      });

      if (deleteMoviesCast != null && deleteMoviesCast.isNotEmpty) {
        deleteMoviesCast.forEach((movie) {
          celebritiesDetails.movieCredits.cast.remove(movie);
        });
      }
    }

    if (celebritiesDetails.movieCredits.crew != null &&
        celebritiesDetails.movieCredits.crew.isNotEmpty) {
      List<MoviesData> deleteMoviesCrew;

      celebritiesDetails.movieCredits.crew.forEach((movie) {
        if (movie.backdropPath == null || movie.posterPath == null) {
          deleteMoviesCrew == null
              ? deleteMoviesCrew = [movie]
              : deleteMoviesCrew.add(movie);
        }
      });

      if (deleteMoviesCrew != null && deleteMoviesCrew.isNotEmpty) {
        deleteMoviesCrew.forEach((movie) {
          celebritiesDetails.movieCredits.crew.remove(movie);
        });
      }
    }
  }

  if (celebritiesDetails.tvCredits != null) {
    if (celebritiesDetails.tvCredits.cast != null &&
        celebritiesDetails.tvCredits.cast.isNotEmpty) {
      List<TvShowsData> deleteTvShowsCast;

      celebritiesDetails.tvCredits.cast.forEach((tvShow) {
        if (tvShow.backdropPath == null || tvShow.posterPath == null) {
          deleteTvShowsCast == null
              ? deleteTvShowsCast = [tvShow]
              : deleteTvShowsCast.add(tvShow);
        }
      });

      if (deleteTvShowsCast != null && deleteTvShowsCast.isNotEmpty) {
        deleteTvShowsCast.forEach((tvShow) {
          celebritiesDetails.tvCredits.cast.remove(tvShow);
        });
      }
    }

    if (celebritiesDetails.tvCredits.crew != null &&
        celebritiesDetails.tvCredits.crew.isNotEmpty) {
      List<TvShowsData> deleteTvShowsCrew;

      celebritiesDetails.tvCredits.crew.forEach((tvShow) {
        if (tvShow.backdropPath == null || tvShow.posterPath == null) {
          deleteTvShowsCrew == null
              ? deleteTvShowsCrew = [tvShow]
              : deleteTvShowsCrew.add(tvShow);
        }
      });

      if (deleteTvShowsCrew != null && deleteTvShowsCrew.isNotEmpty) {
        deleteTvShowsCrew.forEach((tvShow) {
          celebritiesDetails.tvCredits.crew.remove(tvShow);
        });
      }
    }
  }

  return celebritiesDetails;
}
