import 'package:tmdb/core/ui/utils.dart';

final class CelebritiesApiPaths {
  static const _celebs = 'person';

  static const trendingCelebs = 'trending/$_celebs/day';
  static const popularCelebs = '$_celebs/popular';
  static const celebId = 'celeb_id';

  static String categoryCelebs(CelebrityCategories category) {
    switch (category) {
      case CelebrityCategories.Popular:
        return popularCelebs;
      case CelebrityCategories.Trending:
        return trendingCelebs;
    }
  }
}
