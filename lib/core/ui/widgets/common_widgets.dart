import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';

class InternetConnectionErrorWidget extends StatefulWidget {
  final GestureTapCallback onPressed;

  InternetConnectionErrorWidget({required this.onPressed});

  @override
  _InternetConnectionErrorWidgetState createState() =>
      _InternetConnectionErrorWidgetState();
}

class _InternetConnectionErrorWidgetState
    extends State<InternetConnectionErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Check your internet connection !',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          isIOS
              ? CupertinoButton(
                  onPressed: widget.onPressed,
                  child: Text('Tap to Retry'),
                )
              : ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    'Tap to Retry',
                  ),
                ),
        ],
      ),
    );
  }
}
