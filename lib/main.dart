import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'launcher.dart';

bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginInfoProvider>(
      create: (context) => LoginInfoProvider(),
      child: isIOS
          ? CupertinoApp(
              debugShowCheckedModeBanner: false,
              theme: CupertinoThemeData(
                  brightness: Brightness.dark,
                  scaffoldBackgroundColor: Colors.black,
                  barBackgroundColor: Colors.grey[900].withOpacity(0.7),
                  primaryColor: Colors.blue),
              home: Launcher(),
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
              home: Launcher(),
            ),
    );
  }
}
