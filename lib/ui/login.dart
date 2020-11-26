import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/bloc/login/login_bloc.dart';
import 'package:tmdb/bloc/login/login_events.dart';
import 'package:tmdb/bloc/login/login_state/login_state_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_events.dart';
import 'package:tmdb/bloc/login/login_states.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/login/login_repo.dart';
import 'package:tmdb/utils/dialogs/dialogs_utils.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import 'movie_tv_show_app.dart';

enum NavigationCategory { Forward, BackWard }

class Login extends StatefulWidget {
  final NavigationCategory navigationCategory;

  Login({@required this.navigationCategory});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final String _singUpUrl = 'https://www.themoviedb.org/account/signup';
  LoginBloc _loginBloc;
  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _isUserNameEmpty = true;
  bool _isPasswordEmpty = true;
  bool _hidePassword = true;

  @override
  void initState() {
    _loginBloc = LoginBloc(
        loginRepo: LoginRepo(client: getHttpClient(context)),
        loginInfoProvider:
            Provider.of<LoginInfoProvider>(context, listen: false));
    super.initState();
  }

  @override
  void dispose() {
    _userNameTextController.dispose();
    _passwordTextController.dispose();
    _loginBloc.close();
    super.dispose();
  }

  _launchURL() async {
    if (await canLaunch(_singUpUrl)) {
      await launch(_singUpUrl);
    } else {
      throw 'Could not launch $_singUpUrl';
    }
  }

  Widget _buildPasswordWidget(LoginState loginState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          decoration: isIOS
              ? BoxDecoration()
              : BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(color: Colors.grey[800]),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
          child: isIOS
              ? CupertinoTextField(
                  onChanged: (password) {
                    setState(() {
                      _isPasswordEmpty = password.isEmpty;
                    });
                  },
                  obscureText: _hidePassword,
                  controller: _passwordTextController,
                  keyboardType: TextInputType.text,
                  enabled: !(loginState is LoggingIn),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(color: Colors.grey[800]),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.lock,
                      color: Colors.grey[400],
                    ),
                  ),
                  placeholder: 'Password',
                  placeholderStyle: TextStyle(color: Colors.grey),
                  suffix: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      _hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    },
                  ),
                  suffixMode: _isPasswordEmpty
                      ? OverlayVisibilityMode.never
                      : OverlayVisibilityMode.always)
              : TextField(
                  onChanged: (password) {
                    setState(() {
                      _isPasswordEmpty = password.isEmpty;
                    });
                  },
                  controller: _passwordTextController,
                  obscureText: _hidePassword,
                  enabled: !(loginState is LoggingIn),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey[400],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: _isPasswordEmpty
                            ? Container()
                            : Icon(
                                _hidePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400)),
                ),
        ),
      ],
    );
  }

  Widget _buildUsernameWidget(LoginState loginState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          decoration: isIOS
              ? BoxDecoration()
              : BoxDecoration(
                  color: Colors.grey[900],
                  border: Border.all(color: Colors.grey[800]),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
          child: isIOS
              ? CupertinoTextField(
                  onChanged: (username) {
                    setState(() {
                      _isUserNameEmpty = username.isEmpty;
                    });
                  },
                  controller: _userNameTextController,
                  keyboardType: TextInputType.text,
                  enabled: !(loginState is LoggingIn),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(color: Colors.grey[800]),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey[400],
                    ),
                  ),
                  placeholder: 'Username',
                  placeholderStyle: TextStyle(color: Colors.grey),
                  suffix: CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      CupertinoIcons.clear_thick_circled,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        _userNameTextController.clear();
                        _isUserNameEmpty = true;
                      });
                    },
                  ),
                  suffixMode: _isUserNameEmpty
                      ? OverlayVisibilityMode.never
                      : OverlayVisibilityMode.always,
                )
              : TextField(
                  onChanged: (username) {
                    setState(() {
                      _isUserNameEmpty = username.isEmpty;
                    });
                  },
                  controller: _userNameTextController,
                  enabled: !(loginState is LoggingIn),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 14),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey[400],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _userNameTextController.clear();
                            _isUserNameEmpty = true;
                          });
                        },
                        icon: _isUserNameEmpty
                            ? Container()
                            : Icon(
                                Icons.clear,
                                color: Colors.grey[400],
                              ),
                      ),
                      hintText: 'Username',
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.w400)),
                ),
        ),
      ],
    );
  }

  void _continueWithoutSignIn(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(IS_APP_STARTED_FIRST_TIME, false);
    _navigateToMovieTvShowApp(context);
  }

  void _navigateToMovieTvShowApp(BuildContext context) {
    if (widget.navigationCategory == NavigationCategory.Forward) {
      NavigationUtils.navigate(
          context: context, page: MovieTvShowApp(), replacePage: true);
    } else {
      Navigator.pop(context);
    }
  }

  void _signIn(BuildContext context) async {
    if (_userNameTextController.text.trim().isEmpty) {
      DialogUtils.showMessageDialog(context, 'Please Enter User Name!');
    } else if (_passwordTextController.text.trim().isEmpty) {
      DialogUtils.showMessageDialog(context, 'Please Enter Password!');
    } else {
      hideKeyBoard(context);
      _loginBloc.add(LoginUser(
          userName: _userNameTextController.text.trim(),
          password: _passwordTextController.text.trim()));
    }
  }

  Widget body(BuildContext context, double topPadding) {
    return BlocConsumer<LoginBloc, LoginState>(
        cubit: _loginBloc,
        listener: (context, state) {
          if (state is LoginError) {
            DialogUtils.showMessageDialog(context, state.error.toString());
          } else if (state is LoggedIn) {
            context.read<LoginStateBloc>().add(LoginStateEvents.Login);
            Navigator.pop(context);
          }
        },
        builder: (context, loginState) {
          return GestureDetector(
            onTap: () {
              hideKeyBoard(context);
            },
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 20,
                    right: 20),
                width: double.maxFinite,
                height: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black)),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: topPadding + 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, right: 15, left: 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[900],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'TMDb',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _buildUsernameWidget(loginState),
                      SizedBox(
                        height: 20,
                      ),
                      _buildPasswordWidget(loginState),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: double.maxFinite,
                          child: Builder(
                            builder: (context) {
                              return isIOS
                                  ? CupertinoButton(
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 40,
                                          right: 40),
                                      child: loginState is LoggingIn
                                          ? CupertinoActivityIndicator()
                                          : Text(
                                              'Sign in',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                      color: Colors.green[900],
                                      onPressed: loginState is LoggingIn
                                          ? null
                                          : () {
                                              _signIn(context);
                                            },
                                    )
                                  : RaisedButton(
                                      onPressed: loginState is LoggingIn
                                          ? null
                                          : () {
                                              _signIn(context);
                                            },
                                      padding: const EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          left: 40,
                                          right: 40),
                                      color: Colors.green[900],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: loginState is LoggingIn
                                          ? CircularProgressIndicator()
                                          : Text(
                                              'Sign in',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 20),
                                            ),
                                    );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
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
                                  color: Colors.white),
                            ),
                            CupertinoButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: loginState is LoggingIn
                                  ? null
                                  : () => _launchURL(),
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      widget.navigationCategory == NavigationCategory.Forward
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      height: 1,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Text('OR'),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      height: 1,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      widget.navigationCategory == NavigationCategory.Forward
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Builder(builder: (context) {
                                    return isIOS
                                        ? CupertinoButton(
                                            child: Text(
                                              'Continue without signing in',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            color: Colors.green[900],
                                            onPressed: loginState is LoggingIn
                                                ? null
                                                : () {
                                                    _continueWithoutSignIn(
                                                        context);
                                                  },
                                          )
                                        : RaisedButton(
                                            padding: const EdgeInsets.only(
                                                top: 15,
                                                bottom: 15,
                                                left: 40,
                                                right: 40),
                                            color: Colors.green[900],
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            child: Text(
                                              'Continue without signing in',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                            onPressed: loginState is LoggingIn
                                                ? null
                                                : () {
                                                    _continueWithoutSignIn(
                                                        context);
                                                  },
                                          );
                                  })),
                            )
                          : Container()
                    ],
                  ),
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;

    return isIOS
        ? widget.navigationCategory == NavigationCategory.Forward
            ? CupertinoPageScaffold(
                child: body(context, topPadding),
              )
            : CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(),
                child: body(context, topPadding),
              )
        : widget.navigationCategory == NavigationCategory.Forward
            ? Scaffold(
                body: body(context, topPadding),
              )
            : Scaffold(
                appBar: AppBar(),
                body: body(context, 0),
              );
  }
}
