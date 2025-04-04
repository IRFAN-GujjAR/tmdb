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
          onSurface: Colors.white,
        ),
        // // useMaterial3: true
        primaryColor: ConstantColors.PRIMARY_COLOR,
        scaffoldBackgroundColor: ConstantColors.BACKGROUND_COLOR,
        // unselectedWidgetColor: Colors.grey[400],
        iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR),
        // primaryIconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR),
        // textTheme: _textTheme,
        // disabledColor: Colors.grey,
        dividerTheme: DividerThemeData(
          color: Colors.grey[700],
          // color: ConstantColors.PRIMARY_COLOR,
          thickness: 0.2,
        ),
        tabBarTheme: TabBarThemeData(unselectedLabelColor: Colors.grey[400]),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR),
          backgroundColor: ConstantColors.NAV_BAR_COLOR,
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
      onSurface: Colors.white,
    ),
    primaryColor: ConstantColors.PRIMARY_COLOR_DARK,
    scaffoldBackgroundColor: ConstantColors.BACKGROUND_COLOR_DARK,
    // unselectedWidgetColor: Colors.grey[400],
    iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR_DARK),
    // primaryIconTheme: IconThemeData(
    //   color: ConstantColors.PRIMARY_COLOR_DARK,
    // ),
    // disabledColor: Colors.grey,
    tabBarTheme: TabBarThemeData(unselectedLabelColor: Colors.grey[400]),
    appBarTheme: AppBarTheme(
      backgroundColor: ConstantColors.NAV_BAR_COLOR_DARK,
      iconTheme: IconThemeData(color: ConstantColors.PRIMARY_COLOR_DARK),
    ),
    // tabBarTheme: TabBarTheme(
    //   indicator: UnderlineTabIndicator(
    //     borderSide: BorderSide(color: ConstantColors.ACCENT_COLOR_DARK),
    //   ),
    // ),
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

  // static TextTheme get _textTheme => TextTheme(
  //   bodyMedium: TextStyle(color: Colors.white),
  //   bodyLarge: TextStyle(color: Colors.white),
  //   displayLarge: TextStyle(color: Colors.white),
  //   displayMedium: TextStyle(color: Colors.white),
  //   displaySmall: TextStyle(color: Colors.white),
  //   headlineMedium: TextStyle(color: Colors.white),
  //   headlineSmall: TextStyle(color: Colors.white),
  //   titleLarge: TextStyle(color: Colors.white),
  //   titleMedium: TextStyle(color: Colors.grey),
  //   titleSmall: TextStyle(color: Colors.grey),
  // );
  //
  // static ElevatedButtonThemeData get _elevatedButtonThemeData =>
  //     ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: Colors.black,
  //         backgroundColor: ConstantColors.ACCENT_COLOR,
  //         disabledForegroundColor: Colors.grey.withOpacity(0.38),
  //         disabledBackgroundColor: Colors.grey.withOpacity(0.12),
  //       ),
  //     );
  // static ElevatedButtonThemeData get _elevatedButtonDarkThemeData =>
  //     ElevatedButtonThemeData(
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: Colors.black,
  //         backgroundColor: ConstantColors.ACCENT_COLOR_DARK,
  //         disabledForegroundColor: Colors.grey.withOpacity(0.38),
  //         disabledBackgroundColor: Colors.grey.withOpacity(0.12),
  //       ),
  //     );

  // static TextButtonThemeData get _textButtonThemeData => TextButtonThemeData(
  //   style: TextButton.styleFrom(foregroundColor: ConstantColors.ACCENT_COLOR),
  // );

  // static TextButtonThemeData get _textButtonDarkThemeData =>
  //     TextButtonThemeData(
  //       style: TextButton.styleFrom(
  //         foregroundColor: ConstantColors.ACCENT_COLOR_DARK,
  //       ),
  //     );
}
