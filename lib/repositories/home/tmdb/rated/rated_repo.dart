import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/rated_model.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class RatedRepo extends BaseRepo {
  RatedRepo({@required Client client}) : super(client);

  Future<RatedModel> loadRated(UserInfoModel user) async {
    try {
      final movies = await MovieUtilsRepo.getCategoryMovies(
          client: client, url: URLS.ratedMovies(user, 1));
      final tvShows = await TvShowUtilsRepo.getCategoryTvShows(
          client: client, url: URLS.ratedTvShows(user, 1));
      return RatedModel(moviesList: movies, tvShowsList: tvShows);
    } catch (error) {
      throw error;
    }
  }
}
