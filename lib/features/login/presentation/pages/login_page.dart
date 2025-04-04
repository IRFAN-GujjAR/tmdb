import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/assets/custom_icons.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_text_button_widget.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';

import '../../../../core/ui/widgets/custom_body_widget.dart';
import '../blocs/login_bloc.dart';
import '../providers/login_provider.dart';
import '../widgets/continue_button_widget.dart';
import '../widgets/password_txt_field_widget.dart';
import '../widgets/sign_in_button_widget.dart';
import '../widgets/user_name_txt_field_widget.dart';

enum NavigationCategory { Forward, BackWard }

class LoginPage extends StatelessWidget {
  final NavigationCategory navigationCategory;

  LoginPage({required this.navigationCategory});

  Widget body(BuildContext context) {
    final provider = context.read<LoginProvider>();
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        provider.handleLoginBlocState(
          context,
          state: state,
          navigationCategory: navigationCategory,
        );
      },
      builder: (context, loginState) {
        return GestureDetector(
          onTap: () {
            hideKeyBoard(context);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: PagePadding.topPadding + 24,
              left: PagePadding.leftPadding + 8,
              right: PagePadding.rightPadding + 8,
            ),
            child: Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(CustomIcons.tMDB),
                    ),
                  ),
                  SizedBox(height: 20),
                  UserNameTxtFieldWidget(loginState: loginState),
                  SizedBox(height: 20),
                  PasswordTxtFieldWidget(loginState: loginState),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: SignInButtonWidget(loginState: loginState),
                  ),
                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Don't have a account ? ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        CustomTextButtonWidget(
                          onPressed: provider.launchSignUpURL,
                          title: 'SIGN UP',
                          enable: !(loginState is LoginStateLoggingIn),
                        ),
                      ],
                    ),
                  ),
                  if (navigationCategory == NavigationCategory.Forward)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: const DividerWidget(
                              indent: 0,
                              endIndent: 10,
                            ),
                          ),
                          Text('OR'),
                          Expanded(child: const DividerWidget(indent: 10)),
                        ],
                      ),
                    ),
                  if (navigationCategory == NavigationCategory.Forward)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Align(
                        alignment: Alignment.center,
                        child: ContinueButtonWidget(
                          loginState: loginState,
                          navigationCategory: navigationCategory,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // var topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    return navigationCategory == NavigationCategory.Forward
        ? Scaffold(body: CustomBodyWidget(child: body(context)))
        : Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorUtils.scaffoldBackgroundColor(context),
            // systemOverlayStyle: SystemUiOverlayStyle(
            //   statusBarColor: ConstantColors.STATUS_BAR_COLOR.withOpacity(0.3),
            // ),
          ),
          body: CustomBodyWidget(child: body(context)),
        );
  }
}
