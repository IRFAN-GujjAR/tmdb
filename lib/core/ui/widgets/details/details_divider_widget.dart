import 'package:flutter/material.dart';

import '../divider_widget.dart';

final class DetailsDividerWidget extends StatelessWidget {
  final double topPadding;

  const DetailsDividerWidget({super.key, required this.topPadding});

  @override
  Widget build(BuildContext context) {
    return DividerWidget(topPadding: topPadding);
  }
}
