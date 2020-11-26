import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class TvShowsRepo extends BaseRepo {
  TvShowsRepo({@required Client client}) : super(client);

  Future<List<TvShowsList>> get loadTvShowsLists async {
    final airingTodayTvShows = await TvShowUtilsRepo.getCategoryTvShows(
        client: client, url: URLS.airingTodayTvShows(1));
    final trendingTvShows = await TvShowUtilsRepo.getCategoryTvShows(
        client: client, url: URLS.trendingTvShows(1));
    final topRatedTvShows = await TvShowUtilsRepo.getCategoryTvShows(
        client: client, url: URLS.topRatedTvShows(1));
    final popularTvShows = await TvShowUtilsRepo.getCategoryTvShows(
        client: client, url: URLS.popularTvShows(1));
    return [
      airingTodayTvShows,
      trendingTvShows,
      topRatedTvShows,
      popularTvShows
    ];
  }
}
