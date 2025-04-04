import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/login/presentation/blocs/login_bloc.dart';
import 'package:tmdb/features/login/presentation/providers/login_provider.dart';

class SignInButtonWidget extends StatelessWidget {
  final LoginState _loginState;

  const SignInButtonWidget({super.key, required LoginState loginState})
    : _loginState = loginState;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return Container(
      width: double.maxFinite,
      child: FilledButton(
        onPressed:
            _loginState is LoginStateLoggingIn
                ? null
                : () {
                  provider.signIn(context);
                },
        child:
            _loginState is LoginStateLoggingIn
                ? CircularProgressIndicator()
                : const Text('SIGN IN'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
