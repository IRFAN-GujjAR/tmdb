import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/utils/utils.dart';

import 'login.dart';
import 'main.dart';
import 'movie_tv_show_app.dart';
import 'network/common.dart';

class Launcher extends StatefulWidget {
  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {

  @override
  void initState() {
    super.initState();
    _initializeApiKeyAndSessionId();
  }

  _initializeApiKeyAndSessionId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString(SESSION_ID);
    if (sessionId != null && sessionId.isNotEmpty) {
      String accountId = preferences.getString(USER_ID);
      String username = preferences.getString(USER_NAME);
      _loginInfoProvider.signIn(sessionId, accountId, username);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  MovieTvShowApp()));
    } else {
      bool appStartedFirstTime = preferences.getBool(IS_APP_STARTED_FIRST_TIME);
      if (appStartedFirstTime != null && !appStartedFirstTime) {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) =>
                    MovieTvShowApp()));
      } else {
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => Login(
                      navigationCategory: NavigationCategory.Forward,
                    )));
      }
    }
  }

  LoginInfoProvider _loginInfoProvider;

  @override
  Widget build(BuildContext context) {
    _loginInfoProvider = Provider.of<LoginInfoProvider>(context);
    return isIOS
        ? CupertinoPageScaffold(
            child: Container(
              color: Colors.black,
            ),
          )
        : Scaffold(
            body: Container(
              color: Colors.black,
            ),
          );
  }
}
