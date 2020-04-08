import 'package:http/http.dart' as http;
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/utils/utils.dart';
import 'common.dart';

enum MoviesCategories {
  Popular,
  InTheatres,
  Trending,
  TopRated,
  Upcoming,
  DetailsRecommended,
  DetailsSimilar
}

enum TvShowsCategories {
  AiringToday,
  Trending,
  TopRated,
  Popular,
  DetailsRecommended,
  DetailsSimilar
}

enum CelebrityCategories { Popular, Trending }

Map<MoviesCategories, String> _moviesCategory = {
  MoviesCategories.Popular: 'popular',
  MoviesCategories.InTheatres: 'now_playing',
  MoviesCategories.Trending: 'trending',
  MoviesCategories.TopRated: 'top_rated',
  MoviesCategories.Upcoming: 'upcoming',
  MoviesCategories.DetailsRecommended: 'recommendations',
  MoviesCategories.DetailsSimilar: 'similar'
};

Map<TvShowsCategories, String> _tvShowsCategory = {
  TvShowsCategories.AiringToday: 'airing_today',
  TvShowsCategories.Trending: 'trending',
  TvShowsCategories.TopRated: 'top_rated',
  TvShowsCategories.Popular: 'popular',
  TvShowsCategories.DetailsRecommended: 'recommendations',
  TvShowsCategories.DetailsSimilar: 'similar'
};

Future<List<MoviesList>> fetchMovies(http.Client client) async {
  return await _getMovies(client);
}

Future<List<TvShowsList>> fetchTvShows(
    http.Client client) async {
  return await _getTvShows(client);
}

Future<List<CelebritiesList>> fetchCelebrities(
    http.Client client) async {
  return await _getCelebrities(client);
}

Future<List<MoviesList>> _getMovies(http.Client client) async {
  MoviesList popular = await getCategoryMovies(
      client, null, MoviesCategories.Popular, 1);
  MoviesList inTheatres = await getCategoryMovies(
      client, null, MoviesCategories.InTheatres, 1);
  MoviesList trending = await getCategoryMovies(
      client, null, MoviesCategories.Trending, 1);
  MoviesList topRated = await getCategoryMovies(
      client, null, MoviesCategories.TopRated, 1);
  MoviesList upcoming = await getCategoryMovies(
      client, null, MoviesCategories.Upcoming, 1);

  if (popular == null ||
      inTheatres == null ||
      trending == null ||
      topRated == null ||
      upcoming == null) {
    return null;
  }

  MoviesList newUpComing = upcoming;

  if (newUpComing != null) {
    int counter = 2;
    while (newUpComing.movies.length < 20) {
      MoviesList s = await getCategoryMovies(
          client, null, MoviesCategories.Upcoming, counter);
      newUpComing = MoviesList(
          pageNumber: s.pageNumber,
          totalPages: s.totalPages,
          movies: newUpComing.movies);
      newUpComing.movies.addAll(s.movies);
      counter++;
    }
  }

  return [popular, inTheatres, trending, topRated, newUpComing];
}

Future<MoviesList> getCategoryMovies(http.Client client, int movieId,
    MoviesCategories category, int page) async {
  String moviesUrl;

  if (category == MoviesCategories.Trending) {
    moviesUrl =
        'https://api.themoviedb.org/3/trending/movie/day?api_key=$Api_Key&page=$page';
  } else if (category == MoviesCategories.DetailsRecommended) {
    moviesUrl =
        'https://api.themoviedb.org/3/movie/$movieId/${_moviesCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  } else if (category == MoviesCategories.DetailsSimilar) {
    moviesUrl =
        'https://api.themoviedb.org/3/movie/$movieId/${_moviesCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  } else {
    moviesUrl =
        'https://api.themoviedb.org/3/movie/${_moviesCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  }

  var response;
  try {
    response = await client
        .get(moviesUrl)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  MoviesList movies = await convertMoviesResponse(response.body);
  MoviesList correctedMovies = getCorrectMovies(movies);
  if (category == MoviesCategories.Upcoming) {
    List<MoviesData> deleteMovies = [];
    correctedMovies.movies.forEach((movie) {
      if (movie.releaseDate != null) {
        int year, month, day;
        year = int.parse(movie.releaseDate.substring(0, 4));
        month = int.parse(movie.releaseDate.substring(5, 7));
        day = int.parse(movie.releaseDate.substring(8, 10));

        if (DateTime.now().year == year) {
          if (DateTime.now().month == month) {
            if (DateTime.now().day > day) deleteMovies.add(movie);
          } else if (DateTime.now().month > month) {
            deleteMovies.add(movie);
          }
        } else if (DateTime.now().year > year) {
          deleteMovies.add(movie);
        }
      }
    });

    if (deleteMovies.isNotEmpty) {
      deleteMovies.forEach((movie) {
        correctedMovies.movies.remove(movie);
      });
    }
  }
  return correctedMovies;
}

Future<List<TvShowsList>> _getTvShows(http.Client client) async {
  List<TvShowsList> allTvShows = [
    await getCategoryTvShows(
        client, null, TvShowsCategories.AiringToday, 1),
    await getCategoryTvShows(
        client, null, TvShowsCategories.Trending, 1),
    await getCategoryTvShows(
        client, null, TvShowsCategories.TopRated, 1),
    await getCategoryTvShows(
        client, null, TvShowsCategories.Popular, 1),
  ];

  if (allTvShows[0] == null ||
      allTvShows[1] == null ||
      allTvShows[2] == null ||
      allTvShows[3] == null) {
    return null;
  }

  return allTvShows;
}

Future<TvShowsList> getCategoryTvShows(http.Client client, int tvShowId,
    TvShowsCategories category, int page) async {
  String tvShowsUrl;

  if (category == TvShowsCategories.Trending) {
    tvShowsUrl =
        'https://api.themoviedb.org/3/trending/tv/day?api_key=$Api_Key&page=$page';
  } else if (category == TvShowsCategories.DetailsRecommended) {
    tvShowsUrl =
        'https://api.themoviedb.org/3/tv/$tvShowId/${_tvShowsCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  } else if (category == TvShowsCategories.DetailsSimilar) {
    tvShowsUrl =
        'https://api.themoviedb.org/3/tv/$tvShowId/${_tvShowsCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  } else {
    tvShowsUrl =
        'https://api.themoviedb.org/3/tv/${_tvShowsCategory[category]}?api_key=$Api_Key&language=en-US&page=$page';
  }
  var response;
  try {
    response = await client
        .get(tvShowsUrl)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  TvShowsList tvShows = await convertTvShowsResponse(response.body);
  TvShowsList correctedTvShows = getCorrectTvShows(tvShows);

  return correctedTvShows;
}

Future<List<CelebritiesList>> _getCelebrities(
    http.Client client) async {
  CelebritiesList popularCelebrities = await getCategoryCelebrities(
      client, CelebrityCategories.Popular, 1);
  CelebritiesList trendingCelebrities = await getCategoryCelebrities(
      client, CelebrityCategories.Trending, 1);

  if (popularCelebrities == null || trendingCelebrities == null) {
    return null;
  }

  List<CelebritiesList> allCelebrities = [
    popularCelebrities,
    trendingCelebrities
  ];

  return allCelebrities;
}

Future<CelebritiesList> getCategoryCelebrities(http.Client client,
    CelebrityCategories category, int pageNumber) async {
  String url;

  if (category == CelebrityCategories.Popular) {
    url =
        'https://api.themoviedb.org/3/person/popular?api_key=$Api_Key&language=en-US&page=$pageNumber';
  } else {
    url =
        'https://api.themoviedb.org/3/trending/person/day?api_key=$Api_Key&page=$pageNumber';
  }

  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  CelebritiesList celebrities = await convertCelebritiesResponse(response.body);

  return celebrities;
}
