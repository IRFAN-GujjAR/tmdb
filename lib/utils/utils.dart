import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Enter TMDb(https://www.themoviedb.org) Api Key
const String Api_Key = ;

const String SESSION_ID = 'sessionId';
const String USER_ID = 'userId';
const String USER_NAME = 'username';
const String IS_APP_STARTED_FIRST_TIME = 'app_started_first_time';

const String IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/';
const int TIME_OUT_DURATION = 15;

enum MediaType { Movie, TvShow }
const MEDIA_TYPE_VALUE = {MediaType.Movie: 'movie', MediaType.TvShow: 'tv'};

class BackDropSizes {
  static const String w300 = 'w300';
  static const String w780 = 'w780';
  static const String w1280 = 'w1280';
  static const String original = 'original';
}

class LogoSizes {
  static const String w45 = 'w45';
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w300 = 'w300';
  static const String w500 = 'w500';
  static const String original = 'original';
}

class PosterSizes {
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w342 = 'w342';
  static const String w500 = 'w500';
  static const String w780 = 'w780';
  static const String original = 'original';
}

class ProfileSizes {
  static const String w45 = 'w45';
  static const String w185 = 'w185';
  static const String w632 = 'w632';
  static const String original = 'original';
}

class StillSizes {
  static const String w92 = 'w92';
  static const String w185 = 'w185';
  static const String w300 = 'w300';
  static const String original = 'original';
}

String getMovieGenres(List<int> genres) {
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
    37: 'Western'
  };

  String genreString;

  genres.forEach((genre) {
    var genreTest = genreName[genre];
    if (genreString == null) {
      if (genreTest != null) {
        genreString = genreName[genre];
      }
    } else {
      if (genreTest != null) {
        genreString = genreString + ', ' + genreName[genre];
      }
    }
  });

  return genreString == null ? '' : genreString;
}

String getTvShowsGenres(List<int> genres) {
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
    37: 'Western'
  };

  String genreString;

  genres.forEach((genre) {
    var genreTest = genreName[genre];
    if (genreString == null) {
      if (genreTest != null) {
        genreString = genreName[genre];
      }
    } else {
      if (genreTest != null) {
        genreString = genreString + ', ' + genreName[genre];
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

String getThumbnail({
  @required String videoId,
}) =>
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
