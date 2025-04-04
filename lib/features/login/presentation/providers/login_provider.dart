import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/login/presentation/blocs/login_bloc.dart';
import 'package:tmdb/features/login/presentation/blocs/login_status/login_status_bloc.dart';
import 'package:tmdb/features/login/presentation/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/ui/dialogs/dialogs_utils.dart';
import '../../../../core/ui/utils.dart';
import '../../../../core/urls/urls.dart';
import '../../../app_startup/sub_features/app_prefs/presentation/providers/app_prefs_provider.dart';

final class LoginProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _userNameTxtController = TextEditingController();
  TextEditingController get userNameTxtController => _userNameTxtController;

  final _passwordTxtController = TextEditingController();
  TextEditingController get passwordTxtController => _passwordTxtController;

  bool _isUserNameEmpty = true;
  bool get isUserNameEmpty => _isUserNameEmpty;
  set setIsUserNameEmpty(bool value) {
    _isUserNameEmpty = value;
    notifyListeners();
  }

  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;
  set setHidePassword(bool value) {
    _hidePassword = value;
    notifyListeners();
  }

  void signIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      hideKeyBoard(context);
      context.read<LoginBloc>().add(
        LoginEventUser(
          userName: userNameTxtController.text.trim(),
          password: passwordTxtController.text.trim(),
        ),
      );
    }
  }

  void continueWithoutSignIn(
    BuildContext context,
    NavigationCategory navigationCategory,
  ) async {
    await context.read<AppPrefsProvider>().storeAppStartFirstTime(false);
    if (navigationCategory == NavigationCategory.Forward) {
      appRouterConfig.go(context, location: AppRouterPaths.MOVIES);
    } else {
      appRouterConfig.pop(context);
    }
  }

  @override
  void dispose() {
    _userNameTxtController.dispose();
    _passwordTxtController.dispose();
    super.dispose();
  }

  Future<void> launchSignUpURL() async {
    try {
      await launchUrl(Uri.parse(URLS.SIGN_UP));
    } catch (e) {
      logger.e(e);
    }
  }

  void handleLoginBlocState(
    BuildContext context, {
    required LoginState state,
    required NavigationCategory navigationCategory,
  }) {
    switch (state) {
      case LoginStateEmpty():
      case LoginStateLoggingIn():
        break;
      case LoginStateLoggedIn():
        _handleLoggedInState(
          context,
          state: state,
          category: navigationCategory,
        );
        break;
      case LoginStateError():
        DialogUtils.showMessageDialog(context, state.error.error.errorMessage);
    }
  }

  void _handleLoggedInState(
    BuildContext context, {
    required LoginStateLoggedIn state,
    required NavigationCategory category,
  }) {
    context.read<UserSessionProvider>().store(state.userSession).then((value) {
      context.read<LoginStatusBloc>().add(LoginStatusEventLogin());
      if (category == NavigationCategory.Forward)
        appRouterConfig.go(context, location: AppRouterPaths.MOVIES);
      else
        appRouterConfig.pop(context);
    });
  }
}
