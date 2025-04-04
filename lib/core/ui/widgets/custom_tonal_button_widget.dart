import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';

class CustomTonalButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool enable;

  const CustomTonalButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: FilledButton.styleFrom(
        backgroundColor: ColorUtils.primaryColor(context),
      ),
      onPressed: enable ? onPressed : null,
      child: child,
    );
  }
}
