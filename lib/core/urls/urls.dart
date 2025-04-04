import 'package:tmdb/core/ui/utils.dart';

class URLS {
  static const BASE_URL = 'https://api.themoviedb.org/3/';
  static const SIGN_UP = 'https://www.themoviedb.org/account/signup';

  static const _SHARE_BASE_URL = 'https://www.themoviedb.org';

  static String _convertTextToShareableFormat(String title) {
    String shareableTitle = title.replaceAll(' ', '-').toLowerCase();
    return shareableTitle;
  }

  static Uri movieShareUrl({required int movieId, required String title}) {
    return Uri.parse(
      _SHARE_BASE_URL +
          '/movie/$movieId-${_convertTextToShareableFormat(title)}',
    );
  }

  static Uri tvShowShareUrl({required int tvId, required String title}) {
    return Uri.parse(
      _SHARE_BASE_URL + '/tv/$tvId-${_convertTextToShareableFormat(title)}',
    );
  }

  static Uri celebrityShareUrl({
    required int celebId,
    required String celebName,
  }) {
    return Uri.parse(
      _SHARE_BASE_URL +
          '/person/$celebId-${_convertTextToShareableFormat(celebName)}',
    );
  }

  static String profileImageUrl({
    required String imageUrl,
    required ProfileSizes size,
  }) {
    String s = '';
    switch (size) {
      case ProfileSizes.w45:
        s = 'w45';
        break;
      case ProfileSizes.w92:
        s = 'w92';
        break;
      case ProfileSizes.w185:
        s = 'w185';
        break;
      case ProfileSizes.h632:
        s = 'h632';
        break;
      case ProfileSizes.original:
        s = 'original';
        break;
    }
    return IMAGE_BASE_URL + s + imageUrl;
  }

  static String posterImageUrl({
    required String imageUrl,
    required PosterSizes size,
  }) {
    String s = '';
    switch (size) {
      case PosterSizes.w92:
        s = 'w92';
        break;
      case PosterSizes.w154:
        s = 'w154';
        break;
      case PosterSizes.w185:
        s = 'w185';
        break;
      case PosterSizes.w342:
        s = 'w342';
        break;
      case PosterSizes.w500:
        s = 'w500';
        break;
      case PosterSizes.w780:
        s = 'w780';
        break;
      case PosterSizes.original:
        s = 'original';
        break;
    }
    return IMAGE_BASE_URL + s + imageUrl;
  }

  static String backdropImageUrl({
    required String imageUrl,
    required BackdropSizes size,
  }) {
    String s = '';
    switch (size) {
      case BackdropSizes.w300:
        s = 'w300';
        break;
      case BackdropSizes.w780:
        s = 'w780';
        break;
      case BackdropSizes.w1280:
        s = 'w1280';
        break;
      case BackdropSizes.original:
        s = 'original';
        break;
    }
    return IMAGE_BASE_URL + s + imageUrl;
  }

  static String stillImageUrl({
    required String imageUrl,
    required StillSizes size,
  }) {
    String s = '';
    switch (size) {
      case StillSizes.w92:
        s = 'w92';
        break;
      case StillSizes.w185:
        s = 'w185';
        break;
      case StillSizes.w300:
        s = 'w300';
        break;
      case StillSizes.original:
        s = 'original';
        break;
    }
    return IMAGE_BASE_URL + s + imageUrl;
  }
}
