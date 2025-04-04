import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_list_cf_category.dart';

const String SESSION_ID = 'sessionId';
const String USER_ID = 'userId';
const String USER_NAME = 'username';
const String IS_APP_STARTED_FIRST_TIME = 'app_started_first_time';

const String IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/';
const int TIME_OUT_DURATION = 15;

enum MediaType { Movie, TvShow }

extension MediaTypeExtension on MediaType {
  bool get isMovie => this == MediaType.Movie;

  MediaImageType get imageType =>
      isMovie ? MediaImageType.Movie : MediaImageType.TvShow;
}

const MEDIA_TYPE_VALUE = {MediaType.Movie: 'movie', MediaType.TvShow: 'tv'};

enum BackdropSizes { w300, w780, w1280, original }

class LogoSizes {
  static const String w45 = 'w45';
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w300 = 'w300';
  static const String w500 = 'w500';
  static const String original = 'original';
}

enum PosterSizes { w92, w154, w185, w342, w500, w780, original }

enum ProfileSizes { w45, w92, w185, h632, original }

enum StillSizes { w92, w185, w300, original }

String? getMovieGenres(List<int> genres) {
  Map<int, String> genreName = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Science Fiction',
    10770: 'TV Movie',
    53: 'Thriller',
    10752: 'War',
    37: 'Western',
  };

  String? genreString;

  genres.forEach((genre) {
    var genreTest = genreName[genre];
    if (genreString == null) {
      if (genreTest != null) {
        genreString = genreName[genre];
      }
    } else {
      if (genreTest != null) {
        genreString = genreString! + ', ' + genreName[genre]!;
      }
    }
  });

  return genreString == null ? '' : genreString;
}

String? getTvShowsGenres(List<int> genres) {
  Map<int, String> genreName = {
    10759: 'Action & Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    10762: 'Kids',
    9648: 'Mystery',
    10763: 'News',
    10764: 'Reality',
    10765: 'Sci-Fi & Fantasy',
    10766: 'Soap',
    10767: 'Talk',
    10768: 'War & Politics',
    37: 'Western',
  };

  String? genreString;

  genres.forEach((genre) {
    var genreTest = genreName[genre];
    if (genreString == null) {
      if (genreTest != null) {
        genreString = genreName[genre];
      }
    } else {
      if (genreTest != null) {
        genreString = genreString! + ', ' + genreName[genre]!;
      }
    }
  });

  return genreString == null ? '' : genreString;
}

void hideKeyBoard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String getThumbnail({required String videoId}) =>
    'https://i.ytimg.com/vi/$videoId/${ThumbnailQuality.medium}';

class ThumbnailQuality {
  /// 120*90
  static const String defaultQuality = 'default.jpg';

  /// 320*180
  static const String medium = 'mqdefault.jpg';

  /// 480*360
  static const String high = 'hqdefault.jpg';

  /// 640*480
  static const String standard = 'sddefault.jpg';

  /// Unscaled thumbnail
  static const String max = 'maxresdefault.jpg';
}

enum MoviesCategories {
  Popular,
  InTheatres,
  Trending,
  TopRated,
  Upcoming,
  DetailsRecommended,
  DetailsSimilar,
}

extension MoviesCategoriesExtension on MoviesCategories {
  MoviesListCFCategory get cfCategory {
    switch (this) {
      case MoviesCategories.Popular:
        return MoviesListCFCategory.popular;
      case MoviesCategories.InTheatres:
        return MoviesListCFCategory.inTheatres;
      case MoviesCategories.Trending:
        return MoviesListCFCategory.trending;
      case MoviesCategories.TopRated:
        return MoviesListCFCategory.topRated;
      case MoviesCategories.Upcoming:
        return MoviesListCFCategory.upComing;
      case MoviesCategories.DetailsRecommended:
        return MoviesListCFCategory.recommended;
      case MoviesCategories.DetailsSimilar:
        return MoviesListCFCategory.similar;
    }
  }
}

enum TvShowsCategories {
  AiringToday,
  Trending,
  TopRated,
  Popular,
  DetailsRecommended,
  DetailsSimilar,
}

extension TvShowsCategoriesExtension on TvShowsCategories {
  TvShowsListCFCategory get cfCategory {
    switch (this) {
      case TvShowsCategories.AiringToday:
        return TvShowsListCFCategory.airingToday;
      case TvShowsCategories.Trending:
        return TvShowsListCFCategory.trending;
      case TvShowsCategories.TopRated:
        return TvShowsListCFCategory.topRated;
      case TvShowsCategories.Popular:
        return TvShowsListCFCategory.popular;
      case TvShowsCategories.DetailsRecommended:
        return TvShowsListCFCategory.recommended;
      case TvShowsCategories.DetailsSimilar:
        return TvShowsListCFCategory.similar;
    }
  }
}

enum CelebrityCategories { Popular, Trending }

extension CelebrityCategoriesExtension on CelebrityCategories {
  CelebsListCFCategory get cfCategory {
    switch (this) {
      case CelebrityCategories.Popular:
        return CelebsListCFCategory.popular;
      case CelebrityCategories.Trending:
        return CelebsListCFCategory.trending;
    }
  }
}

Map<MoviesCategories, String> movieCategoryName = {
  MoviesCategories.Popular: 'Popular',
  MoviesCategories.InTheatres: 'Playing In Theatres',
  MoviesCategories.Trending: 'Trending',
  MoviesCategories.TopRated: 'Top Rated',
  MoviesCategories.Upcoming: 'Upcoming',
  MoviesCategories.DetailsRecommended: 'Recommended',
  MoviesCategories.DetailsSimilar: 'Similar',
};

Map<TvShowsCategories, String> tvShowsCategoryName = {
  TvShowsCategories.AiringToday: 'Airing Today',
  TvShowsCategories.Trending: 'Trending',
  TvShowsCategories.TopRated: 'Top Rated',
  TvShowsCategories.Popular: 'Popular',
  TvShowsCategories.DetailsRecommended: 'Recommended',
  TvShowsCategories.DetailsSimilar: 'Similar',
};

enum MediaImageType { Movie, TvShow, Celebrity }

extension MediaImageTypeExtension on MediaImageType {
  bool get isMovie => this == MediaImageType.Movie;
  bool get isTvShow => this == MediaImageType.TvShow;
  bool get isCelebrity => this == MediaImageType.Celebrity;
}
