import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/theme/theme_utils.dart';

class DialogUtils {
  static Future<void> showMessageDialog(
      BuildContext context, String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: ThemeUtils.isLightMode(context)
                ? ColorUtils.scaffoldBackgroundColor(context)
                : Colors.grey[900],
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  static Future<bool> showAlertDialog(
      BuildContext context, String message) async {
    bool yes = false;

    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            content: Text(message),
            actions: <Widget>[
              MaterialButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                child: Text('Yes'),
                onPressed: () {
                  yes = true;
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });

    return yes;
  }
}
