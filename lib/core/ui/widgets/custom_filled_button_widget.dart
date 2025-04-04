import 'package:flutter/material.dart';

class CustomFilledButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final bool enable;
  final ButtonStyle? style;

  const CustomFilledButtonWidget({
    super.key,
    required this.onPressed,
    required this.child,
    this.enable = true,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: enable ? onPressed : null,
      child: child,
      style: style,
    );
  }
}
