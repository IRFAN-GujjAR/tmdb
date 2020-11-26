import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/api_provider.dart';

class TvShowUtilsRepo {
  static Future<TvShowsList> getCategoryTvShows(
      {@required Client client, @required String url}) async {
    try {
      final json = await ApiProvider.get(url: url, httpClient: client);
      final tvShows = TvShowsList.fromJson(json);
      return getCorrectTvShows(tvShows);
    } catch (error) {
      throw error;
    }
  }

  static TvShowsList getCorrectTvShows(TvShowsList tvShowsList) {
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
}
