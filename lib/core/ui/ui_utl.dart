import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final class UIUtl {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void showSnackBar(BuildContext context, {required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  static Future<void> get hideStatusBar =>
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  static Future<void> get showStatusBar => SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: SystemUiOverlay.values,
  );
}
