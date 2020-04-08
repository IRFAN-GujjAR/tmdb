import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';

class InternetConnectionErrorWidget extends StatefulWidget {
  final GestureTapCallback onPressed;

  InternetConnectionErrorWidget({@required this.onPressed});

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
              : RaisedButton(
                  onPressed: widget.onPressed,
                  child: Text(
                    'Tap to Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  color: Colors.black,
                ),
        ],
      ),
    );
  }
}

Widget buildRatingWidget(double voteAverage, int voteCount) {
  List<IconData> stars;

  double rating = voteAverage / 2;
  int counter = rating.toInt();

  for (int i = 0; i < counter; i++) {
    stars == null ? stars = [Icons.star] : stars.add(Icons.star);
  }

  if (rating.toString().contains('.')) {
    if (voteCount == 0 && voteAverage == 0) {
      stars = [Icons.star_border];
    } else {
      stars == null ? stars = [Icons.star_half] : stars.add(Icons.star_half);
    }
  }
  while (stars.length < 5) {
    stars.add(Icons.star_border);
  }

  return Container(
    margin: const EdgeInsets.only(top: 2, left: 4),
    height: 15,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return index != 5
            ? Icon(
                stars[index],
                size: 15,
                color: Colors.blue,
              )
            : Padding(
                padding: const EdgeInsets.only(left: 5, top: 2),
                child: Text(
                  '( $voteCount )',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ));
      },
      itemCount: 6,
    ),
  );
}
