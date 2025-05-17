import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/router/app_router_config.dart';
import 'package:tmdb/features/ads_manager/data/data_sources/ads_manager_data_source.dart';
import 'package:tmdb/features/ads_manager/data/db/dao/ads_manager_dao.dart';
import 'package:tmdb/features/ads_manager/data/repositories/ads_manager_repo_impl.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_reset.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_update.dart';
import 'package:tmdb/features/ads_manager/domain/use_cases/ads_manager_use_case_watch.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/main.dart';

import '../../features/app_startup/sub_features/app_prefs/data/data_sources/app_prefs_data_source.dart';
import '../../features/app_startup/sub_features/app_prefs/data/repositories/app_prefs_repo_impl.dart';
import '../../features/app_startup/sub_features/app_prefs/presentation/providers/app_prefs_provider.dart';
import '../../features/app_startup/sub_features/user_session/data/data_sources/user_session_data_source.dart';
import '../../features/app_startup/sub_features/user_session/data/repositories/user_session_repo_impl.dart';
import '../../features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import '../providers/theme_provider.dart';

GetIt get locator => GetIt.instance;
Logger get logger => locator.get<Logger>();
AppRouterConfig get appRouterConfig => locator.get<AppRouterConfig>();
AppDatabase get appDatabase => locator.get<AppDatabase>();

Future<void> get initializeFlutterApp async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebaseApp;
  await MobileAds.instance.initialize();
  locator.registerSingleton(AppDatabase());
  runApp(await _initializeServicesApp);
}

Future<void> get _initializeFirebaseApp async {
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.debug,
  );
  await FirebaseRemoteConfig.instance.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 5),
      minimumFetchInterval: Duration(hours: 1),
    ),
  );
  if (kDebugMode) await _setupFunctionsEmulator;
  CloudFunctionsUtl().initializeSingletons;
}

Future<Widget> get _initializeServicesApp async {
  locator.registerLazySingleton(() => Logger());
  _initializeAppRouterConfig;
  final appPrefsProvider = await _loadAppPrefs;
  final adsManagerRepo = AdsManagerRepoImpl(
    AdsManagerDataSourceImpl(AdsManagerDao(appDatabase)),
  );
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<AppPrefsProvider>.value(value: appPrefsProvider),
      ChangeNotifierProvider<ThemeProvider>(
        create:
            (_) =>
                ThemeProvider()..initializeTheme(
                  appTheme: appPrefsProvider.appPrefs.appTheme,
                ),
      ),
      ChangeNotifierProvider<UserSessionProvider>(
        create:
            (_) => UserSessionProvider(
              UserSessionRepoImpl(UserSessionDataSourceImpl()),
            ),
      ),
      BlocProvider<AdsManagerBloc>(
        create:
            (_) => AdsManagerBloc(
              AdsManagerUseCaseWatch(adsManagerRepo),
              AdsManagerUseCaseUpdate(adsManagerRepo),
              AdsManagerUseCaseReset(adsManagerRepo),
            ),
      ),
      ChangeNotifierProvider<AdsManagerProvider>(
        create: (_) => AdsManagerProvider(),
      ),
    ],
    child: MyApp(),
  );
}

void get _initializeAppRouterConfig {
  locator.registerSingleton(AppRouterConfig());
}

Future<AppPrefsProvider> get _loadAppPrefs async {
  final prefs = await SharedPreferences.getInstance();
  final appPrefsProvider = AppPrefsProvider(
    AppPrefsRepoImpl(AppPrefsDataSourceImpl(prefs)),
  );
  appPrefsProvider.loadValuesWithoutNotify;
  return appPrefsProvider;
}

Future<void> get _setupFunctionsEmulator async {
  await dotenv.load(fileName: '.env');
  final host = await dotenv.env['HOST']!;
  final port = int.parse(await dotenv.env['PORT']!);
  FirebaseFunctions.instance.useFunctionsEmulator(host, port);
}
