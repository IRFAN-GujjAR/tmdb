final class SearchApiPaths {
  static const String _search = '/search';
  static const String _searchMovies = '$_search/movie';
  static const String _searchTvShows = '$_search/tv';
  static const String _searchCelebs = '$_search/person';

  static String _appendQuery(String path, String query) =>
      '$path?query=$query&include_adult=false&language=en-US';

  static String searchMovies(String query) =>
      _appendQuery(_searchMovies, query);
  static String searchTvShows(String query) =>
      _appendQuery(_searchTvShows, query);
  static String searchCelebs(String query) =>
      _appendQuery(_searchCelebs, query);
}
