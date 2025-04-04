import 'package:flutter/material.dart';

class MoviePosterPlaceHolderWidget extends StatelessWidget {
  final double size;

  const MoviePosterPlaceHolderWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.local_movies,
      size: size,
    );
  }
}
