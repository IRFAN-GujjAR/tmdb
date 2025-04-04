import 'package:tmdb/core/ui/theme/theme_utils.dart';

import '../entities/app_prefs_entity.dart';

abstract class AppPrefsRepo {
  AppPrefsEntity get getPreferences;
  Future<void> storeAppStartFirstTime(bool value);
  Future<void> storeAppTheme(AppThemes appTheme);
}
