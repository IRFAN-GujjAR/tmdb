import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CelebrityProfilePlaceholderWidget extends StatelessWidget {
  final double size;

  const CelebrityProfilePlaceholderWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      CupertinoIcons.person_solid,
      size: size,
      color: Colors.grey,
    );
  }
}
