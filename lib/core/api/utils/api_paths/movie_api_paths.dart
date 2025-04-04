import 'package:tmdb/core/api/utils/api_query_field_names.dart';
import 'package:tmdb/core/api/utils/query_values/language.dart';
import 'package:tmdb/core/ui/utils.dart';

import '../query_values/sort_by.dart';

final class MovieApiPaths {
  static const popularMovies = '/movie/popular';
  static const inTheatreMovies = '/movie/now_playing';
  static const trendingMovies = '/trending/movie/day';
  static const topRatedMovies = '/movie/top_rated';
  static const upComingMovies = '/movie/upcoming';

  static const String movieId = 'movie_id';

  static String recommendedMovies(int movieId) =>
      '/movie/$movieId/recommendations';
  static String similarMovies(int movieId) => '/movie/$movieId/similar';

  static String categoryMovies(MoviesCategories category, {int? movieId}) {
    if ((category == MoviesCategories.DetailsRecommended ||
            category == MoviesCategories.DetailsSimilar) &&
        movieId == null) {
      throw ('Movie Id cannot be null');
    }
    switch (category) {
      case MoviesCategories.Popular:
        return popularMovies;
      case MoviesCategories.InTheatres:
        return inTheatreMovies;
      case MoviesCategories.Trending:
        return trendingMovies;
      case MoviesCategories.TopRated:
        return topRatedMovies;
      case MoviesCategories.Upcoming:
        return upComingMovies;
      case MoviesCategories.DetailsRecommended:
        return recommendedMovies(movieId!);
      case MoviesCategories.DetailsSimilar:
        return similarMovies(movieId!);
    }
  }

  static String favoriteMovies({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/favorite/movies?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }

  static String ratedMovies({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/rated/movies?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }

  static String watchlistMovies({
    required int userId,
    required String sessionId,
    required int pageNo,
  }) {
    return 'account/$userId/watchlist/movies?${APIQueryFieldNames.language}=${ApiQueryValuesLanguage.ENGLISH}&${APIQueryFieldNames.page}=$pageNo&${APIQueryFieldNames.sessionId}=$sessionId&${APIQueryFieldNames.sortBy}=${APIQueryValuesSortBy.CREATED_AT_ASC}';
  }
}
