import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';
import 'package:tmdb/features/app_startup/sub_features/app_prefs/presentation/providers/app_prefs_provider.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _materialTheme;
  ThemeData get materialTheme => _materialTheme;

  late AppThemes _appTheme;
  AppThemes get appTheme => _appTheme;

  bool get isDeviceTheme => _appTheme == AppThemes.DeviceTheme;
  bool get isLightTheme => _appTheme == AppThemes.LightTheme;
  bool get isDarkTheme => _appTheme == AppThemes.DarkTheme;

  void initializeTheme({required AppThemes appTheme}) {
    _appTheme = appTheme;
    switch (appTheme) {
      case AppThemes.DeviceTheme:
        _materialTheme = ThemeUtils.lightThemeMaterial;
        break;
      case AppThemes.LightTheme:
        _materialTheme = ThemeUtils.lightThemeMaterial;
        break;
      case AppThemes.DarkTheme:
        _materialTheme = ThemeUtils.darkThemeMaterial;
        break;
    }
  }

  void setTheme(BuildContext context, {required AppThemes appTheme}) {
    initializeTheme(appTheme: appTheme);
    notifyListeners();
    context.read<AppPrefsProvider>().storeAppTheme(appTheme);
  }
}
