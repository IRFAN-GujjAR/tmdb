import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/login/presentation/blocs/login_bloc.dart';
import 'package:tmdb/features/login/presentation/providers/login_provider.dart';

import '../../../../core/ui/widgets/custom_text_form_field_widget.dart';

class UserNameTxtFieldWidget extends StatelessWidget {
  final LoginState _loginState;

  const UserNameTxtFieldWidget({super.key, required LoginState loginState})
      : _loginState = loginState;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return CustomTextFormFieldWidget(
          enabled: !(_loginState is LoginStateLoggingIn),
          controller: provider.userNameTxtController,
          labelText: 'Username',
          prefixIcon: Icons.person,
          autofillHint: AutofillHints.username,
          suffixWidget: provider.isUserNameEmpty
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    provider.userNameTxtController.clear();
                    provider.setIsUserNameEmpty = true;
                  },
                ),
          onChanged: (value) {
            provider.setIsUserNameEmpty = value.isEmpty;
          },
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Please enter username';
            }
            return null;
          },
        );
      },
    );
  }
}
