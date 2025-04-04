import 'package:flutter/material.dart';

class MovieBackdropPlaceHolderWidget extends StatelessWidget {
  final double size;

  const MovieBackdropPlaceHolderWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.movie,
      size: size,
    );
  }
}
