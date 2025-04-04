import 'package:flutter/cupertino.dart';
import 'package:tmdb/core/ui/ui_utl.dart';

final class AssetIllustrations {
  static const String _basePath = 'assets/illustrations/';

  static String networkError(BuildContext context) => UIUtl.isDarkMode(context)
      ? _internetConnectionErrorDark
      : _internetConnectionErrorLight;
  static const String _internetConnectionErrorLight =
      _basePath + 'internet_connection_error_light.png';
  static const String _internetConnectionErrorDark =
      _basePath + 'internet_connection_error_dark.png';

  static String unknownError(BuildContext context) =>
      UIUtl.isDarkMode(context) ? _unknownErrorDark : _unknownErrorLight;
  static const String _unknownErrorLight =
      _basePath + 'unknown_error_light.png';
  static const String _unknownErrorDark = _basePath + 'unknown_error_dark.png';

  static String searchResultsNotFound(BuildContext context) =>
      UIUtl.isDarkMode(context)
          ? _searchResultsNotFoundDark
          : _searchResultsNotFoundLight;
  static const String _searchResultsNotFoundLight =
      _basePath + 'search_results_not_found_light.png';
  static const String _searchResultsNotFoundDark =
      _basePath + 'search_results_not_found_dark.png';

  static String serverError(BuildContext context) =>
      UIUtl.isDarkMode(context) ? _serverErrorDark : _serverErrorLight;
  static const String _serverErrorLight = _basePath + 'server_error_light.png';
  static const String _serverErrorDark = _basePath + 'server_error_dark.png';
}
