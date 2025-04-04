import 'package:flutter/material.dart';

class ColorUtils {
  static Color primaryColor(BuildContext context) {
    return Theme.of(context).primaryColor;
  }

  static Color scaffoldBackgroundColor(BuildContext context) {
    return Theme.of(context).scaffoldBackgroundColor;
  }

  static Color appBarColor(BuildContext context, {bool isIOSOpacity = false}) {
    return Theme.of(context).appBarTheme.backgroundColor!;
  }

  static Color accentColor(BuildContext context) {
    return Theme.of(context).colorScheme.secondary;
  }

  static Color dividerColor(BuildContext context) {
    return Colors.grey[900]!;
  }
}
