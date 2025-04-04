import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/login/presentation/blocs/login_bloc.dart';
import 'package:tmdb/features/login/presentation/pages/login_page.dart';
import 'package:tmdb/features/login/presentation/providers/login_provider.dart';

class ContinueButtonWidget extends StatelessWidget {
  final LoginState _loginState;
  final NavigationCategory _navigationCategory;

  const ContinueButtonWidget({
    super.key,
    required LoginState loginState,
    required NavigationCategory navigationCategory,
  }) : _loginState = loginState,
       _navigationCategory = navigationCategory;

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
                  provider.continueWithoutSignIn(context, _navigationCategory);
                },
        child: Text('CONTINUE'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
