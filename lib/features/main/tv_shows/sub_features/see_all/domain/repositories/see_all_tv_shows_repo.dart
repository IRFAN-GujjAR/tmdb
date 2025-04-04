import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';

abstract class SeeAllTvShowsRepo {
  Future<TvShowsListEntity> getTvShows({
    required Map<String, dynamic> cfParams,
  });
}
