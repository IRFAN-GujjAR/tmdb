import 'package:flutter/material.dart';

class TvBackdropPlaceHolderWidget extends StatelessWidget {
  final double size;

  const TvBackdropPlaceHolderWidget({required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.live_tv,
      size: size,
    );
  }
}
