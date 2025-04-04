import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool enable;

  const CustomTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: enable ? onPressed : null, child: Text(title));
  }
}
