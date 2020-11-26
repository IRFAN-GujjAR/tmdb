import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';

class NavigationUtils {
  static void navigate(
      {@required BuildContext context,
      bool rootNavigator = false,
      @required dynamic page,
      bool removePreviousPages = false,
      bool replacePage = false}) {
    final route = isIOS
        ? CupertinoPageRoute(builder: (context) => page)
        : MaterialPageRoute(builder: (context) => page);
    if (removePreviousPages) {
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushAndRemoveUntil(route, (route) => false);
    } else if (replacePage) {
      Navigator.of(context, rootNavigator: rootNavigator)
          .pushReplacement(route);
    } else {
      Navigator.of(context, rootNavigator: rootNavigator).push(route);
    }
  }

  static void navigateToRoot(BuildContext context) {
    var navigator = Navigator.of(context);
    while (navigator.canPop()) {
      navigator.pop();
    }
  }

  static void navigateBack(BuildContext context, int numberOfScreens) {
    int count = 1;
    Navigator.of(context).popUntil((_) => count++ >= numberOfScreens);
  }
}
