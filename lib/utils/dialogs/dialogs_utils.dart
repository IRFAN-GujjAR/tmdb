import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';

class DialogUtils {
  static Future<void> showMessageDialog(
      BuildContext context, String message) async {
    return isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                content: Text(
                  message,
                ),
                actions: <Widget>[
                  CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'),
                  )
                ],
              );
            })
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(message),
                actions: [
                  FlatButton(
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

    isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(message),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                content: Text(message),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
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
