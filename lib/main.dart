import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/providers/theme_provider.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_state.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/login/presentation/blocs/login_status/login_status_bloc.dart';

import 'core/ui/initialize_app.dart';
import 'core/ui/theme/theme_utils.dart';

bool get isIOS => Platform.isIOS;

Future<void> main() async {
  await initializeFlutterApp;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder:
          (context, provider, _) => BlocProvider(
            create: (context) => LoginStatusBloc(),
            child: BlocListener<AdsManagerBloc, AdsManagerState>(
              listener: (context, state) {
                context.read<AdsManagerProvider>().handleBlocState(
                  context.read<AdsManagerBloc>(),
                  state,
                );
              },
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: appRouterConfig.appRouter,
                theme: provider.materialTheme,
                darkTheme:
                    provider.isDeviceTheme
                        ? ThemeUtils.darkThemeMaterial
                        : provider.materialTheme,
              ),
            ),
          ),
    );
  }
}
