import 'package:flutter/material.dart';

class CustomIconButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool enable;

  const CustomIconButtonWidget({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      onPressed: enable ? onPressed : null,
      color: enable ? null : Colors.grey,
      icon: Icon(icon, color: enable ? null : Colors.grey),
    );
  }
}
