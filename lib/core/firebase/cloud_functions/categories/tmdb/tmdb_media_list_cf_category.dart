enum TMDbMediaListCFCategory { favorites, ratings, watchlist }

extension TMDbMediaListCFCategoryExtension on TMDbMediaListCFCategory {
  String get title {
    switch (this) {
      case TMDbMediaListCFCategory.favorites:
        return 'Favorites';
      case TMDbMediaListCFCategory.ratings:
        return 'Ratings';
      case TMDbMediaListCFCategory.watchlist:
        return 'Watchlist';
    }
  }
}
