import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/widgets/custom_text_form_field_widget.dart';
import '../blocs/login_bloc.dart';
import '../providers/login_provider.dart';

class PasswordTxtFieldWidget extends StatelessWidget {
  final LoginState _loginState;

  const PasswordTxtFieldWidget({super.key, required LoginState loginState})
      : _loginState = loginState;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return CustomTextFormFieldWidget(
          enabled: !(_loginState is LoginStateLoggingIn),
          controller: provider.passwordTxtController,
          labelText: 'Password',
          prefixIcon: Icons.lock,
          autofillHint: AutofillHints.password,
          suffixWidget: IconButton(
            icon: Icon(
              provider.hidePassword ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              provider.setHidePassword = !provider.hidePassword;
            },
          ),
          obscureText: provider.hidePassword,
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Please enter password';
            }
            return null;
          },
        );
      },
    );
  }
}
