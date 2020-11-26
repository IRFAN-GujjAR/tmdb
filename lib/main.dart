import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_bloc.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/provider/bottom_navigation_provider.dart';
import 'package:tmdb/ui/login.dart';
import 'package:tmdb/ui/movie_tv_show_app.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/utils/shared_pref/shared_pref_utils.dart';

bool get isIOS => Platform.isIOS;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  bool appStartedFirstTime = SharedPrefUtils.isAppStartedForFirstTime(pref);
  UserInfoModel userInfo;
  bool isAppStartedForFirstTime = true;
  if (appStartedFirstTime != null && !appStartedFirstTime) {
    isAppStartedForFirstTime = false;
    if (!SharedPrefUtils.isUserDetailsEmpty(pref)) {
      userInfo = await SharedPrefUtils.loadUserDetails(pref);
    }
  }
  runApp(MyApp(
    userInfo: userInfo,
    isAppStartedFirstTime: isAppStartedForFirstTime,
  ));
}

class MyApp extends StatelessWidget {
  final UserInfoModel userInfo;
  final bool isAppStartedFirstTime;

  MyApp({@required this.userInfo, @required this.isAppStartedFirstTime});

  @override
  Widget build(BuildContext context) {
    final home = userInfo != null || !isAppStartedFirstTime
        ? MovieTvShowApp()
        : Login(
            navigationCategory: NavigationCategory.Forward,
          );

    return Provider<Client>(
      create: (_) => Client(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginInfoProvider>(
              create: (_) => LoginInfoProvider(userInfo: userInfo)),
          ChangeNotifierProvider<BottomNavigationProvider>(
              create: (_) => BottomNavigationProvider())
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginStateBloc>(create: (_) => LoginStateBloc()),
            BlocProvider<MediaStateChangesBloc>(
                create: (_) => MediaStateChangesBloc())
          ],
          child: isIOS
              ? CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  theme: CupertinoThemeData(
                      brightness: Brightness.dark,
                      scaffoldBackgroundColor: Colors.black,
                      barBackgroundColor: Colors.grey[900].withOpacity(0.7),
                      primaryColor: Colors.blue),
                  home: home,
                )
              : MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      brightness: Brightness.dark,
                      scaffoldBackgroundColor: Colors.black,
                      appBarTheme: AppBarTheme(
                        color: Colors.black,
                      ),
                      primaryColor: Colors.black),
                  home: home,
                ),
        ),
      ),
    );
  }
}
