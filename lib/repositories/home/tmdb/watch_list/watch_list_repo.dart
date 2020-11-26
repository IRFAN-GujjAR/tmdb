import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/models/watchlist_model.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class WatchListRepo extends BaseRepo {
  WatchListRepo({@required Client client}) : super(client);

  Future<WatchListModel> loadWatchList(UserInfoModel user) async {
    try {
      final movies = await MovieUtilsRepo.getCategoryMovies(
          client: client, url: URLS.watchListMovies(user, 1));
      final tvShows = await TvShowUtilsRepo.getCategoryTvShows(
          client: client, url: URLS.watchListTvShows(user, 1));
      return WatchListModel(moviesList: movies, tvShowsList: tvShows);
    } catch (error) {
      throw error;
    }
  }
}
