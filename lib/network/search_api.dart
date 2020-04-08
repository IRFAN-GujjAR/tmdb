import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/utils/utils.dart';

import 'common.dart';

Future<List<String>> getTrendingSearches(
    http.Client client) async {
  final url = 'https://api.themoviedb.org/3/trending/all/day?api_key=$Api_Key';
  var response;
  try {
    response = await client.get(url);
  } on Exception {
    return null;
  }
  final parsed = json.decode(response.body)['results'];
  final List<String> trendingSearches = parsed.map<String>((json) {
    String mediaType = json['media_type'] as String;
    if (mediaType == 'movie') {
      return json['title'] as String;
    } else {
      return json['name'] as String;
    }
  }).toList();

  return trendingSearches;
}

Future<List<String>> getSearchQueries(
    http.Client client, String query) async {
  final url =
      'https://api.themoviedb.org/3/search/multi?api_key=$Api_Key&language=en-US&query=$query&page=1&include_adult=false';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final parsed = json.decode(response.body)['results'];
  final List<String> trendingSearches = parsed.map<String>((json) {
    String mediaType = json['media_type'] as String;
    if (mediaType == 'movie') {
      return json['title'] as String;
    } else {
      return json['name'] as String;
    }
  }).toList();

  return trendingSearches;
}

Future<MoviesList> searchMovies(
    http.Client client, String query, int pageNumber) async {
  final url =
      'https://api.themoviedb.org/3/search/movie?api_key=$Api_Key&language=en-US&query=$query&page=$pageNumber';
  http.Response response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final movies = await convertMoviesResponse(response.body);
  final correctedMovies = getCorrectMovies(movies);
  return correctedMovies;
}

Future<TvShowsList> searchTvShows(
    http.Client client, String query, int pageNumber) async {
  final url =
      'https://api.themoviedb.org/3/search/tv?api_key=$Api_Key&language=en-US&query=$query&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final tvShows = await convertTvShowsResponse(response.body);
  final correctedTvShows = getCorrectTvShows(tvShows);
  return correctedTvShows;
}

Future<CelebritiesList> searchCelebrities(
    http.Client client, String query, int pageNumber) async {
  final url =
      'https://api.themoviedb.org/3/search/person?api_key=$Api_Key&language=en-US&query=$query&page=$pageNumber';
  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final celebrities = await convertCelebritiesResponse(response.body);
  return celebrities;
}
