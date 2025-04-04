import 'package:flutter/material.dart';

class TvPosterPlaceholderWidget extends StatelessWidget {
  final double size;

  const TvPosterPlaceholderWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.tv,
      size: size,
    );
  }
}
