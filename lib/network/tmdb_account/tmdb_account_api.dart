import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/common/rating/Rate.dart';
import 'package:tmdb/models/account_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tmdb_list.dart';
import 'package:tmdb/models/tmdb_list_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/utils/utils.dart';
import '../common.dart';

Future<AccountData> getAccountDetails(String sessionId) async {
  final String url =
      'https://api.themoviedb.org/3/account?api_key=$Api_Key&session_id=$sessionId';
  var response = await http.get(url);
  return AccountData.fromJson(jsonDecode(response.body));
}

Future<MoviesList> getFavouriteMovies(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/favorite/movies?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  MoviesList favouriteMovies = await convertMoviesResponse(response.body);
  return favouriteMovies;
}

Future<TvShowsList> getFavouriteTvShows(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/favorite/tv?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  TvShowsList favouriteTvShows = await convertTvShowsResponse(response.body);
  return favouriteTvShows;
}

Future<MoviesList> getRatedMovies(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/rated/movies?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  MoviesList ratedMovies = await convertMoviesResponse(response.body);
  return ratedMovies;
}

Future<TvShowsList> getRatedTvShows(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/rated/tv?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  TvShowsList ratedTvShows = await convertTvShowsResponse(response.body);
  return ratedTvShows;
}

Future<MoviesList> getWatchListMovies(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/watchlist/movies?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  MoviesList watchListMovies = await convertMoviesResponse(response.body);
  return watchListMovies;
}

Future<TvShowsList> getWatchListTvShows(http.Client client,
    String sessionId, String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/watchlist/tv?api_key=$Api_Key&session_id=$sessionId&language=en-US&sort_by=created_at.asc&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  TvShowsList watchListTvShows = await convertTvShowsResponse(response.body);
  return watchListTvShows;
}

Future<bool> markMovieAsFavourite(
    http.Client client,
    String movieId,
    String accountId,
    String sessionId,
    bool markFavourite) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/favorite?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body =
      '{ "media_type": "movie","media_id": $movieId,"favorite": $markFavourite}';
  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  int code = jsonDecode(response.body)['status_code'];
  if (code == 1) {
    return true;
  } else {
    return false;
  }
}

Future<bool> markTvShowAsFavourite(
    http.Client client,
    String tvShowId,
    String accountId,
    String sessionId,
    bool markFavourite) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/favorite?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body =
      '{ "media_type": "tv","media_id": $tvShowId,"favorite": $markFavourite}';
  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  int code = jsonDecode(response.body)['status_code'];
  if (code == 1) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkMovieIsFavourite(
    http.Client client, String sessionId, String userId, int movieId) async {
  int pageNumber = 1;
  bool movieMatched = false;
  do {
    MoviesList favouriteMovies =
        await getFavouriteMovies(client, sessionId, userId, pageNumber);
    if (favouriteMovies == null ||
        favouriteMovies.movies == null ||
        favouriteMovies.movies.isEmpty) {
      break;
    } else {
      for (int i = 0; i < favouriteMovies.movies.length; i++) {
        if (movieId == favouriteMovies.movies[i].id) {
          movieMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!movieMatched);

  return movieMatched;
}

Future<bool> checkTvShowIsFavourite(http.Client client, String sessionId,
    String accountId, int tvShowId) async {
  int pageNumber = 1;
  bool tvShowMatched = false;
  do {
    TvShowsList favouriteTvShows =
        await getFavouriteTvShows(client, sessionId, accountId, pageNumber);
    if (favouriteTvShows == null ||
        favouriteTvShows.tvShows == null ||
        favouriteTvShows.tvShows.isEmpty) {
      break;
    } else {
      for (int i = 0; i < favouriteTvShows.tvShows.length; i++) {
        if (tvShowId == favouriteTvShows.tvShows[i].id) {
          tvShowMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!tvShowMatched);

  return tvShowMatched;
}

Future<bool> addMovieToWatchList(
    http.Client client,
    String sessionId,
    String accountId,
    int movieId,
    bool addToWatchList) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/watchlist?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body =
      '{ "media_type": "movie","media_id": $movieId,"watchlist": $addToWatchList}';
  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  int code = jsonDecode(response.body)['status_code'];
  if (code == 1) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkMovieIsAddedToWatchList(
    http.Client client, String sessionId, String userId, int movieId) async {
  int pageNumber = 1;
  bool movieMatched = false;
  do {
    MoviesList ratedMovies =
        await getWatchListMovies(client, sessionId, userId, pageNumber);
    if (ratedMovies == null ||
        ratedMovies.movies == null ||
        ratedMovies.movies.isEmpty) {
      break;
    } else {
      for (int i = 0; i < ratedMovies.movies.length; i++) {
        if (movieId == ratedMovies.movies[i].id) {
          movieMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!movieMatched);

  return movieMatched;
}

Future<bool> addTvShowToWatchList(
    http.Client client,
    String sessionId,
    String accountId,
    int tvShowId,
    bool addToWatchList) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/watchlist?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body =
      '{ "media_type": "tv","media_id": $tvShowId,"watchlist": $addToWatchList}';

  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  int code = jsonDecode(response.body)['status_code'];
  if (code == 1) {
    return true;
  } else {
    return false;
  }
}

Future<bool> checkTvShowIsAddedToWatchList(http.Client client,
    String sessionId, String userId, int tvShowId) async {
  int pageNumber = 1;
  bool tvShowMatched = false;
  do {
    TvShowsList ratedTvShows = await getWatchListTvShows(
        client, sessionId, userId, pageNumber);
    if (ratedTvShows == null ||
        ratedTvShows.tvShows == null ||
        ratedTvShows.tvShows.isEmpty) {
      break;
    } else {
      for (int i = 0; i < ratedTvShows.tvShows.length; i++) {
        if (tvShowId == ratedTvShows.tvShows[i].id) {
          tvShowMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!tvShowMatched);

  return tvShowMatched;
}

Future<int> checkMovieIsRated(
    http.Client client, String sessionId, String userId, int movieId) async {
  int pageNumber = 1;
  bool movieMatched = false;
  int rating = 0;
  do {
    MoviesList ratedMovies =
        await getRatedMovies(client, sessionId, userId, pageNumber);
    if (ratedMovies == null ||
        ratedMovies.movies == null ||
        ratedMovies.movies.isEmpty) {
      break;
    } else {
      for (int i = 0; i < ratedMovies.movies.length; i++) {
        if (movieId == ratedMovies.movies[i].id) {
          rating = ratedMovies.movies[i].rating.toInt();
          movieMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!movieMatched);

  return rating;
}

Future<int> checkTvShowIsRated(
    http.Client client, String sessionId, String userId, int tvShowId) async {
  int pageNumber = 1;
  bool tvShowMatched = false;
  int rating = 0;
  do {
    TvShowsList ratedTvShows =
        await getRatedTvShows(client, sessionId, userId, pageNumber);
    if (ratedTvShows == null ||
        ratedTvShows.tvShows == null ||
        ratedTvShows.tvShows.isEmpty) {
      break;
    } else {
      for (int i = 0; i < ratedTvShows.tvShows.length; i++) {
        if (tvShowId == ratedTvShows.tvShows[i].id) {
          rating = ratedTvShows.tvShows[i].rating.toInt();
          tvShowMatched = true;
          break;
        }
      }
    }
    pageNumber++;
  } while (!tvShowMatched);

  return rating;
}

Future<bool> rateMovie(http.Client client, String sessionId, int mediaId,
    double rating, RatingCategory ratingCategory) async {
  final String url =
      'https://api.themoviedb.org/3/${ratingCategory == RatingCategory.Movie ? 'movie' : 'tv'}/$mediaId/rating?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body = '{"value":$rating}';

  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return false;
  }
  int code = jsonDecode(response.body)['status_code'];

  if (code == 1 || code == 12) {
    return true;
  } else {
    return false;
  }
}

Future<bool> deleteRating(http.Client client, String sessionId, int mediaId,
    double rating, RatingCategory ratingCategory) async {
  final String url =
      'https://api.themoviedb.org/3/${ratingCategory == RatingCategory.Movie ? 'movie' : 'tv'}/$mediaId/rating?api_key=$Api_Key&session_id=$sessionId';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  http.Response response;
  try {
    response = await client
        .delete(url, headers: headers)
        .timeout(Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  int code = jsonDecode(response.body)['status_code'];
  if (code == 13) {
    return true;
  } else {
    return false;
  }
}

Future<TMDbList> getCreatedLists(http.Client client, String sessionId,
    String accountId, int pageNumber) async {
  final String url =
      'https://api.themoviedb.org/3/account/$accountId/lists?api_key=$Api_Key&language=en-US&session_id=$sessionId&page=$pageNumber';
  final response = await client.get(url);
  final tMDbList = await _getTMDbList(response.body);
  return tMDbList;
}

Future<TMDbList> _getTMDbList(String responseBody) async {
  final parsed = json.decode(responseBody)['results'];
  final totalPages = json.decode(responseBody)['total_pages'] as int;
  final pageNumber = json.decode(responseBody)['page'] as int;
  if (totalPages == 0 || parsed == null) {
    return null;
  }

  final List<TMDbListData> tMDbLists =
      parsed.map<TMDbListData>((json) => TMDbListData.fromJson(json)).toList();

  return TMDbList(
      pageNumber: pageNumber, totalPages: totalPages, tmbLists: tMDbLists);
}
