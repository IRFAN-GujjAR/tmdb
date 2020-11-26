import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/favourite_model.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class FavouriteRepo extends BaseRepo {
  FavouriteRepo({@required Client client}) : super(client);

  Future<FavouriteModel> loadFavourite(UserInfoModel user) async {
    try {
      final moviesList = await MovieUtilsRepo.getCategoryMovies(
          client: client, url: URLS.favouriteMovies(user, 1));
      final tvShowsList = await TvShowUtilsRepo.getCategoryTvShows(
          client: client, url: URLS.favouriteTvShows(user, 1));
      return FavouriteModel(moviesList: moviesList, tvShowsList: tvShowsList);
    } catch (error) {
      throw error;
    }
  }
}
