import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/material_theme_utils.dart';

class ThemeUtils {
  static bool isLightMode(BuildContext context) =>
      MediaQuery.of(context).platformBrightness == Brightness.light;

  static ThemeData get lightThemeMaterial => MaterialThemeUtils.lightTheme;
  static ThemeData get darkThemeMaterial => MaterialThemeUtils.darkTheme;
}

enum AppThemes { DeviceTheme, LightTheme, DarkTheme }

Map<AppThemes, String> appThemeName = {
  AppThemes.DeviceTheme: 'Device Theme',
  AppThemes.LightTheme: 'Light Theme',
  AppThemes.DarkTheme: 'Dark Theme'
};
