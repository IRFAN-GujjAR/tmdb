import 'package:flutter/material.dart';

class CustomBodyWidget extends StatelessWidget {
  final Widget child;

  const CustomBodyWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
