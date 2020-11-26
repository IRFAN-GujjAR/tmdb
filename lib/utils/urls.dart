import 'package:flutter/material.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/utils/utils.dart';

class URLS {
  static const _API = 'https://api.themoviedb.org/3/';

  static String _appendUrlWithApiKeyAndPage(String url, int page) =>
      url + '?api_key=$Api_Key&language=en-US&page=$page';

  //Movies URLS

  static const _MOVIE = _API + 'movie/';

  static String trendingMovies(int page) =>
      _API + _appendUrlWithApiKeyAndPage('trending/movie/day', page);

  static String popularMovies(int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + 'popular', page);

  static String inTheatresMovies(int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + 'now_playing', page);

  static String topRatedMovies(int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + 'top_rated', page);

  static String upComingMovies(int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + 'upcoming', page);

  static String recommendedMovies(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + '$movieId/recommendations', page);

  static String similarMovies(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage(_MOVIE + '$movieId/similar', page);

  static String favouriteMovies(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/favorite/movies?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String ratedMovies(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/rated/movies?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String watchListMovies(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/watchlist/movies?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  //Tv URLS

  static const _TV = _API + 'tv/';

  static String trendingTvShows(int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'trending/tv/day', page);

  static String airingTodayTvShows(int page) =>
      _appendUrlWithApiKeyAndPage(_TV + 'airing_today', page);

  static String topRatedTvShows(int page) =>
      _appendUrlWithApiKeyAndPage(_TV + 'top_rated', page);

  static String popularTvShows(int page) =>
      _appendUrlWithApiKeyAndPage(_TV + 'popular', page);

  static String recommendedTvShows(int tvShowId, int page) =>
      _appendUrlWithApiKeyAndPage(_TV + '$tvShowId/recommendations', page);

  static String similarTvShows(int tvShowId, int page) =>
      _appendUrlWithApiKeyAndPage(_TV + '$tvShowId/similar', page);

  static String favouriteTvShows(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/favorite/tv?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String ratedTvShows(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/rated/tv?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  static String watchListTvShows(UserInfoModel user, int page) =>
      '${_API}account/${user.userId}/watchlist/tv?api_key=$Api_Key&session_id=${user.sessionId}&language=en-US&sort_by=created_at.asc&page=$page';

  //Celebrities URLS
  static const _CELEB = _API + 'person/';

  static String trendingCelebrities(int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'trending/person/day', page);

  static String popularCelebrities(int page) =>
      _appendUrlWithApiKeyAndPage(_CELEB + 'popular', page);

  //Search URLS
  static String trendingSearches(int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'trending/all/day', page);

  static String _appendWithSearchURL(String url, String query, int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'search/' + url, page) +
      '&query=$query';

  static String search(String query, int page) =>
      _appendWithSearchURL('multi', query, page);

  static String searchMovies(String query, int page) =>
      _appendWithSearchURL('movie', query, page);

  static String searchTvShows(String query, int page) =>
      _appendWithSearchURL('tv', query, page);

  static String searchCelebritiest(String query, int page) =>
      _appendWithSearchURL('person', query, page);

  //Movie Details URL
  static String movieDetails(int movieId) =>
      _appendUrlWithApiKeyAndPage(_API + 'movie/$movieId', 1) +
      '&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  static String movieStates(int movieId, String sessionId) =>
      '$_MOVIE$movieId/account_states?api_key=$Api_Key&session_id=$sessionId';

  //Collection Details URL
  static String collectionDetails(int movieId, int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'collection/$movieId', page);

  //Tv Show Details URL
  static String tvShowDetails(int tvId) =>
      _appendUrlWithApiKeyAndPage(_API + 'tv/$tvId', 1) +
      '&append_to_response=credits%2Cimages%2Cvideos%2Crecommendations%2Csimilar';

  static String tvShowStates(int tvId, String sessionId) =>
      '$_TV$tvId/account_states?api_key=$Api_Key&language=en-US&session_id=$sessionId';

  //Season Details URL
  static String seasonDetails(int tvId, int seasonNumber, int page) =>
      _appendUrlWithApiKeyAndPage(_API + 'tv/$tvId/season/$seasonNumber', page);

  //Celebrities Details URL
  static String celebritiesDetails(int celebId) =>
      _appendUrlWithApiKeyAndPage(_API + 'person/$celebId', 1) +
      '&append_to_response=movie_credits%2Ctv_credits';

  //Media TMDb URLS
  static String mediaFavourite(UserInfoModel user) =>
      '${_API}account/${user.userId}/favorite?api_key=$Api_Key&session_id=${user.sessionId}';

  static String mediaRate(
          {@required UserInfoModel user,
          @required MediaType mediaType,
          @required int mediaId}) =>
      '$_API${MEDIA_TYPE_VALUE[mediaType]}/$mediaId/rating?api_key=$Api_Key&session_id=${user.sessionId}';

  static String mediaWatchList(UserInfoModel user) =>
      '${_API}account/${user.userId}/watchlist?api_key=$Api_Key&session_id=${user.sessionId}';

  //Login URLS
  static const CREATE_REQUEST_TOKEN =
      '${_API}authentication/token/new?api_key=$Api_Key';
  static const VERIFY_REQUEST_TOKEN =
      '${_API}authentication/token/validate_with_login?api_key=$Api_Key';
  static const CREATE_SESSION_ID =
      '${_API}authentication/session/new?api_key=$Api_Key';
  static String accountDetails(String sessionId) =>
      '${_API}account?api_key=$Api_Key&session_id=$sessionId';
}
