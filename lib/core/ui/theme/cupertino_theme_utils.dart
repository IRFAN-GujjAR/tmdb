import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/constant_colors.dart';

class CupertinoThemeUtils {
  static CupertinoThemeData lightTheme(BuildContext context) =>
      CupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: ConstantColors.BACKGROUND_COLOR,
          barBackgroundColor: ConstantColors.PRIMARY_COLOR.withOpacity(0.7),
          primaryColor: ConstantColors.ACCENT_COLOR,
          textTheme: cupertinoTextTheme(context));
  static CupertinoThemeData darkTheme(BuildContext context) =>
      CupertinoThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          barBackgroundColor: Colors.grey[900]!.withOpacity(0.7),
          primaryColor: ConstantColors.ACCENT_COLOR,
          textTheme: cupertinoTextTheme(context));

  static CupertinoTextThemeData cupertinoTextTheme(BuildContext context) =>
      CupertinoTextThemeData(
          textStyle: TextStyle(color: Colors.white),
          navTitleTextStyle: CupertinoTheme.of(context)
              .textTheme
              .navTitleTextStyle
              .apply(color: Colors.white),
          navLargeTitleTextStyle: CupertinoTheme.of(context)
              .textTheme
              .navLargeTitleTextStyle
              .apply(color: Colors.white),
          navActionTextStyle: CupertinoTheme.of(context)
              .textTheme
              .navActionTextStyle
              .apply(color: ConstantColors.ACCENT_COLOR));
}
