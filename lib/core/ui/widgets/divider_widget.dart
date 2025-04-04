import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/screen_utils.dart';

class DividerWidget extends StatelessWidget {
  final double indent;
  final double endIndent;
  final double topPadding;
  final double bottomPadding;
  final double height;

  const DividerWidget({
    Key? key,
    this.indent = PagePadding.leftPadding,
    this.endIndent = 0,
    this.topPadding = 0,
    this.bottomPadding = 0,
    this.height = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
      child: Divider(indent: indent, endIndent: endIndent, height: height),
    );
  }
}
