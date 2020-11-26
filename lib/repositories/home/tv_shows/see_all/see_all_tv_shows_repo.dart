import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_events.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_utils_repo.dart';

class SeeAllTvShowsRepo extends BaseRepo {
  SeeAllTvShowsRepo({@required Client client}) : super(client);

  Future<TvShowsList> loadMoreTvShows(LoadMoreSeeAllTvShows event) async {
    try {
      final newTvShows = await TvShowUtilsRepo.getCategoryTvShows(
          client: client, url: event.url);
      return TvShowsList(
          pageNumber: newTvShows.pageNumber,
          totalPages: newTvShows.totalPages,
          tvShows: event.previousTvShows.tvShows + newTvShows.tvShows);
    } catch (error) {
      throw error;
    }
  }
}
