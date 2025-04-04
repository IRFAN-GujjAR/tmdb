import 'package:tmdb/core/api/utils/query_values/sort_by.dart';
import 'package:tmdb/core/ui/utils.dart';

import '../api_query_field_names.dart';
import '../query_values/language.dart';

final class TvShowApiPaths {
  static const trendingTvShows = 'trending/tv/day';
  static const airingTodayTVShows = 'tv/airing_today';
  static const topRatedTVShows = 'tv/top_rated';
  static const popularTVShows = 'tv/popular';

  static const tvId = 'tv_id';
  static const seasonNo = 'season_no';
  static String recommendedTvShows(int tvId) => '/tv/$tvId/recommendations';
  static String similarTvShows(int tvId) => '/tv/$tvId/similar';

  static String categoryTvShows(TvShowsCategories category, {int? tvId}) {
    if ((category == TvShowsCategories.DetailsRecommended ||
            category == TvShowsCategories.DetailsSimilar) &&
        tvId == null) {
      throw ('Tv Id cannot be null');
    }
    switch (category) {
      case TvShowsCategories.AiringToday:
        return airingTodayTVShows;
      case TvShowsCategories.Trending:
        return trendingTvShows;
      case TvShowsCategories.TopRated:
        return topRatedTVShows;
      case TvShowsCategories.Popular:
        return popularTVShows;
      case TvShowsCategories.DetailsRecommended:
        return recommendedTvShows(tvId!);
      case TvShowsCategories.DetailsSimilar:
        return similarTvShows(tvId!);
    }
  }

  static String favoriteTvShows({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/favorite/tv?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }

  static String ratedTvShows({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/rated/tv?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }

  static String watchlistTvShows({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/watchlist/tv?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }
}
