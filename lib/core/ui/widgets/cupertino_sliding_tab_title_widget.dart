import 'package:flutter/material.dart';

class CupertinoSlidingTabTitleWidget extends StatelessWidget {
  final String title;

  const CupertinoSlidingTabTitleWidget({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.w500),
    );
  }
}
