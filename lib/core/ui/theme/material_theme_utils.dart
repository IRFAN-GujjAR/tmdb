import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/constant_colors.dart';

class MaterialThemeUtils {
  static ThemeData get lightTheme =>
      ThemeData.dark(useMaterial3: true).copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ConstantColors.SEED_COLOR,
          primary: ConstantColors.PRIMARY_COLOR,
          onPrimary: Colors.black,
          secondary: ConstantColors.SECONDARY_COLOR,
        ),
        primaryColor: ConstantColors.PRIMARY_COLOR,
        scaffoldBackgroundColor: ConstantColors.BACKGROUND_COLOR,
        iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR),
        dividerTheme: DividerThemeData(color: Colors.grey[700], thickness: 0.2),
        tabBarTheme: TabBarThemeData(unselectedLabelColor: Colors.grey[400]),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR),
          backgroundColor: ConstantColors.NAV_BAR_COLOR,
          titleTextStyle: _appBarTitleTextStyle,
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: ConstantColors.NAV_BAR_COLOR,
          indicatorColor: ConstantColors.PRIMARY_COLOR,
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: ConstantColors.PRIMARY_COLOR,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              );
            }
            return TextStyle(color: Colors.grey, fontSize: 12);
          }),
        ),
      );

  static ThemeData get darkTheme => ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: ConstantColors.SEED_COLOR_DARK,
      primary: ConstantColors.PRIMARY_COLOR_DARK,
      secondary: ConstantColors.SECONDARY_COLOR_DARK,
    ),
    primaryColor: ConstantColors.PRIMARY_COLOR_DARK,
    scaffoldBackgroundColor: ConstantColors.BACKGROUND_COLOR_DARK,
    iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR_DARK),
    tabBarTheme: TabBarThemeData(unselectedLabelColor: Colors.grey[400]),
    appBarTheme: AppBarTheme(
      backgroundColor: ConstantColors.NAV_BAR_COLOR_DARK,
      iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR_DARK),
      titleTextStyle: _appBarTitleTextStyle,
    ),
    dividerTheme: DividerThemeData(color: Colors.grey[800], thickness: 0.2),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ConstantColors.NAV_BAR_COLOR_DARK,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      indicatorColor: ConstantColors.PRIMARY_COLOR_DARK,
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: ConstantColors.PRIMARY_COLOR_DARK,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          );
        }
        return TextStyle(color: Colors.grey, fontSize: 12);
      }),
    ),
  );

  static TextStyle get _appBarTitleTextStyle => const TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w400, // Medium
  );
}
