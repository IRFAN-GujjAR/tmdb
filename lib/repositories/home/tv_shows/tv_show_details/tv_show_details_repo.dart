import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class TvShowDetailsRepo extends BaseRepo {
  TvShowDetailsRepo({@required Client client}) : super(client);

  Future<TvShowDetailsData> loadTvShowDetails(int tvId) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.tvShowDetails(tvId), httpClient: client);

      final tvShowDetails = TvShowDetailsData.fromJson(json);

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
    } catch (error) {
      throw error;
    }
  }
}
