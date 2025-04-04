import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';

import '../models/app_prefs_model.dart';

abstract class AppPrefsDataSource {
  AppPrefsModel get getPreferences;
  Future<void> storeAppStartFirstTime(bool value);
  Future<void> storeAppTheme(AppThemes appTheme);
}

final class AppPrefsDataSourceImpl implements AppPrefsDataSource {
  final SharedPreferences _pref;
  final _APP_STARTED_FIRST_TIME = 'app_started_first_time';
  final _APP_THEME = 'app_theme';

  AppPrefsDataSourceImpl(this._pref);

  @override
  AppPrefsModel get getPreferences {
    final appStartFirstTime = _pref.getBool(_APP_STARTED_FIRST_TIME) ?? true;
    final appThemeIndex = _pref.getInt(_APP_THEME) ?? 0;
    AppThemes appTheme = AppThemes.DeviceTheme;
    switch (appThemeIndex) {
      case 1:
        appTheme = AppThemes.LightTheme;
        break;
      case 2:
        appTheme = AppThemes.DarkTheme;
        break;
    }
    return AppPrefsModel(
        appStartedForFirstTime: appStartFirstTime, appTheme: appTheme);
  }

  @override
  Future<void> storeAppStartFirstTime(bool value) async {
    await _pref.setBool(_APP_STARTED_FIRST_TIME, value);
  }

  @override
  Future<void> storeAppTheme(AppThemes appTheme) async {
    await _pref.setInt(_APP_THEME, appTheme.index);
  }
}
