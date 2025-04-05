final class AppRouterPaths {
  static const INITIAL_LOCATION = _APP_STARTUP;
  static const _APP_STARTUP = '/app_startup';
  static const LOGIN = '/login';
  static const MOVIES = '/movies';
  static const TV_SHOWS = '/tv_shows';
  static const CELEBRITIES = '/celebrities';
  static const SEARCH = '/search';
  static const TMDb = '/tmdb';

  static const DETAILS = 'details';

  static const MOVIE_DETAILS = '/movie_details';
  static const TV_SHOW_DETAILS = '/tv_show_details';
  static const CELEBRITY_DETAILS = '/celebrity_details';
  static const SEARCH_DETAILS = '/search_details';

  static const CELEBRITY_PHOTO = '/celebrity_photo';
  static const SEE_ALL_CAST_CREW = '/see_all_cast_crew';

  static const SEE_ALL_MOVIES = '/see_all_movies';
  static const SEE_ALL_TV_SHOWS = '/see_all_tv_shows';
  static const SEE_ALL_CELEBS = '/see_all_celebs';

  static const SEE_ALL_MOVIE_CREDITS_NAME = 'see_all_movie_credits';
  static const SEE_ALL_MOVIE_CREDITS_LOCATION =
      '$CELEBRITY_DETAILS/see_all_movie_credits';

  static const SEE_ALL_TV_CREDITS_NAME = 'see_all_tv_credits';
  static const SEE_ALL_TV_CREDITS_LOCATION =
      '$CELEBRITY_DETAILS/see_all_tv_credits';

  static const MOVIE_COLLECTION_DETAILS_NAME = 'collection_details';
  static const MOVIE_COLLECTION_DETAILS_LOCATION =
      '$MOVIE_DETAILS/$MOVIE_COLLECTION_DETAILS_NAME';

  static const TV_SHOW_SEASON_DETAILS_NAME = 'season_details';
  static const TV_SHOW_SEASON_DETAILS_LOCATION =
      '$TV_SHOW_DETAILS/$TV_SHOW_SEASON_DETAILS_NAME';

  static const SEE_ALL_SEASONS_NAME = 'see_all_seasons';
  static const SEE_ALL_SEASONS_LOCATION =
      '$TV_SHOW_DETAILS/$SEE_ALL_SEASONS_NAME';

  static const APPEARANCES_NAME = 'appearances';
  static const APPEARANCES_LOCATION = '$TMDb/$APPEARANCES_NAME';

  static const ABOUT_NAME = 'about';
  static const ABOUT_LOCATION = '$TMDb/$ABOUT_NAME';

  static const TMDb_MEDIA_LIST_NAME = 'tmdb_media_list';
  static const TMDb_MEDIA_LIST_LOCATION = '$TMDb/$TMDb_MEDIA_LIST_NAME';

  static const FAVOURITE_NAME = 'favourite';
  static const FAVOURITE_LOCATION = '$TMDb/$FAVOURITE_NAME';

  static const WATCHLIST_NAME = 'watchlist';
  static const WATCHLIST_LOCATION = '$TMDb/$WATCHLIST_NAME';

  static const RATINGS_NAME = 'ratings';
  static const RATINGS_LOCATION = '$TMDb/$RATINGS_NAME';

  static const RATE = '/rate';
}
