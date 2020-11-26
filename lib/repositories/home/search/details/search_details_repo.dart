import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/search_details_model.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_utils_repo.dart';
import 'package:tmdb/repositories/home/movies/movie_utils_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class SearchDetailsRepo extends BaseRepo {
  SearchDetailsRepo({@required Client client}) : super(client);

  Future<SearchDetailsModel> loadSearchDetails(String query) async {
    try {
      final searchedMovies = await MovieUtilsRepo.getCategoryMovies(
          client: client, url: URLS.searchMovies(query, 1));
      final searchedTvShows = await TvShowUtilsRepo.getCategoryTvShows(
          client: client, url: URLS.searchTvShows(query, 1));
      final searchedCelebrities =
          await CelebritiesUtilsRepo.getCategoryCelebrities(
              client: client, url: URLS.searchCelebritiest(query, 1));
      return SearchDetailsModel(
          moviesList: searchedMovies,
          tvShowsList: searchedTvShows,
          celebritiesList: searchedCelebrities);
    } catch (error) {
      throw error;
    }
  }
}
