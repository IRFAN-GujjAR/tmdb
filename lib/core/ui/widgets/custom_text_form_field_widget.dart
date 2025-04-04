import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final bool enabled;
  final TextEditingController? controller;
  final String? hintText;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final String autofillHint;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextFormFieldWidget({
    Key? key,
    this.enabled = true,
    this.controller,
    this.hintText,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.suffixWidget,
    this.validator,
    this.onChanged,
    required this.autofillHint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      autofillHints: [autofillHint],
      style: TextStyle(color: Colors.white),
      obscureText: obscureText,

      decoration: InputDecoration(
        prefixIcon:
            prefixIcon != null
                ? Icon(
                  prefixIcon,
                  color: Theme.of(context).unselectedWidgetColor,
                )
                : null,
        suffixIcon:
            suffixWidget != null
                ? suffixWidget
                : suffixIcon != null
                ? Icon(
                  suffixIcon,
                  color: Theme.of(context).unselectedWidgetColor,
                )
                : null,
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey[200]),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
