import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/details/celebrities_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class CelebritiesDetailsRepo extends BaseRepo {
  CelebritiesDetailsRepo({@required Client client}) : super(client);

  Future<CelebritiesDetailsData> loadCelebritiesDetails(int celebId) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.celebritiesDetails(celebId), httpClient: client);
      final celebritiesDetails = CelebritiesDetailsData.fromJson(json);

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
    } catch (error) {
      throw error;
    }
  }
}
