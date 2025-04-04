import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';

import '../../domain/entities/app_prefs_entity.dart';
import '../../domain/repositories/app_prefs_repo.dart';
import '../../domain/use_cases/app_prefs_load_values_use_case.dart';
import '../../domain/use_cases/app_prefs_store_app_start_first_time_use_case.dart';
import '../../domain/use_cases/app_prefs_store_app_theme_use_case.dart';

final class AppPrefsProvider extends ChangeNotifier {
  late AppPrefsLoadValuesUseCase _loadValuesUseCase;
  late AppPrefsStoreAppStartFirstTimeUseCase _storeAppStartFirstTimeUseCase;
  late AppPrefsSaveAppThemeUseCase _saveAppThemeUseCase;

  AppPrefsProvider(AppPrefsRepo appPrefsRepo) {
    _loadValuesUseCase = AppPrefsLoadValuesUseCase(appPrefsRepo);
    _storeAppStartFirstTimeUseCase =
        AppPrefsStoreAppStartFirstTimeUseCase(appPrefsRepo);
    _saveAppThemeUseCase = AppPrefsSaveAppThemeUseCase(appPrefsRepo);
  }

  AppPrefsEntity _appPrefs = AppPrefsEntity(
      appStartedForFirstTime: true, appTheme: AppThemes.DeviceTheme);
  AppPrefsEntity get appPrefs => _appPrefs;

  void get loadValuesWithoutNotify {
    _appPrefs = _loadValuesUseCase.call;
  }

  void get loadValues {
    _appPrefs = _loadValuesUseCase.call;
    notifyListeners();
  }

  Future<void> storeAppStartFirstTime(bool value) async {
    await _storeAppStartFirstTimeUseCase.call(value);
    _appPrefs = AppPrefsEntity(
        appStartedForFirstTime: value, appTheme: _appPrefs.appTheme);
    notifyListeners();
  }

  Future<void> storeAppTheme(AppThemes theme) async {
    await _saveAppThemeUseCase.call(theme);
    _appPrefs = AppPrefsEntity(
        appStartedForFirstTime: _appPrefs.appStartedForFirstTime,
        appTheme: theme);
    notifyListeners();
  }
}
