// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tmdb/core/navigation/navigation_page_constants.dart';
// import 'package:tmdb/features/app_startup/domain/entities/api_keys_entity.dart';
// import 'package:tmdb/features/app_startup/domain/entities/app_local_info_entity.dart';
// import 'package:tmdb/features/app_startup/domain/entities/app_version_entity.dart';
// import 'package:tmdb/features/app_startup/presentation/bloc/app_startup_bloc.dart';
// import 'package:tmdb/provider/login_info_provider.dart';
// import 'package:tmdb/core/utils/initialize_app.dart';
// import 'package:tmdb/core/navigation/navigation_utils.dart';
//
// final class AppStartupProvider extends ChangeNotifier {
//   ApiKeysEntity? _apiKeys;
//   AppLocalInfoEntity? _appLocalInfo;
//
//   void handleAppStartupBlocState(BuildContext context, AppStartupState state) {
//     switch (state) {
//       case AppStartupStateInitial():
//       case AppStartupStateCheckingAppVersion():
//         break;
//       case AppStartupStateCheckAppVersionSuccess():
//         _onCheckAppVersionSuccess(context, state.appVersion);
//         break;
//       case AppStartupStateCheckAppVersionFailure():
//         logger.e('AppCheckVersion Failure');
//         break;
//       case AppStartupStateFetchingApiKeys():
//         break;
//       case AppStartupStateFetchApiKeysSuccess():
//         _onFetchApiKeysSuccess(context, state.apiKeys);
//         break;
//       case AppStartupStateFetchApiKeysFailure():
//         logger.e('FetchApiKeys Failure: ${state.errorMsg}');
//         break;
//       case AppStartupStateLoadingAppLocalInfo():
//         break;
//       case AppStartupStateLoadAppLocalInfoSuccess():
//         _onLoadAppLocalInfoSuccess(context, state.appLocalInfo);
//         break;
//       case AppStartupStateLoadAppLocalInfoFailure():
//       // TODO: Handle this case.
//     }
//   }
//
//   void _onCheckAppVersionSuccess(
//       BuildContext context, AppVersionEntity appVersion) {
//     print(appVersion.minRequiredVersion);
//     if (appVersion.minRequiredVersion != appVersion.installedVersion) {
//       // TODO: Show Dialog Box to update app
//     } else {
//       context.read<AppStartupBloc>().add(AppStartupEventLoadApiKeys());
//     }
//   }
//
//   void _onFetchApiKeysSuccess(BuildContext context, ApiKeysEntity apiKeys) {
//     _apiKeys = apiKeys;
//     print(_apiKeys.toString());
//     context.read<AppStartupBloc>().add(AppStartupEventLoadAppLocalInfo());
//   }
//
//   void _onLoadAppLocalInfoSuccess(
//       BuildContext context, AppLocalInfoEntity appLocalInfo) {
//     _appLocalInfo = appLocalInfo;
//     if (_appLocalInfo!.userInfo != null) {
//       context.read<LoginInfoProvider>().setUserInfo = _appLocalInfo!.userInfo!;
//     }
//     locator.registerSingleton(_apiKeys!);
//     final home =
//         _appLocalInfo!.userInfo != null || !_appLocalInfo!.appFirstTimeLaunch
//             ? NavigationPageType.main
//             : NavigationPageType.login;
//     NavigationUtils.navigate(
//         context: context, pageType: home, replacePage: true);
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/app_startup/presentation/bloc/app_startup_bloc.dart';
import 'package:tmdb/features/app_startup/sub_features/app_prefs/presentation/providers/app_prefs_provider.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/login/presentation/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/ui/initialize_app.dart';

final class AppStartupProvider extends ChangeNotifier {
  Future<void> get updateApp async {
    final Uri playStoreUrl = Uri.parse(
      "https://play.google.com/store/apps/details?id=com.irfangujjar.tmdb",
    );

    if (!await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication)) {
      throw "Could not launch $playStoreUrl";
    }
  }

  void handleBlocState(BuildContext context, AppStartupState state) async {
    switch (state) {
      case AppStartupStateInitial():
      case AppStartupStateLoadingRemoteConfig():
        break;
      case AppStartupStateRemoteConfigLoaded():
        if (state.remoteConfig.appVersion.isRequiredVersionInstalled) {
          context.read<AppStartupBloc>().add(AppStartupEvent.LoadUserSession);
          context.read<AdsManagerProvider>().setAdmobIds =
              state.remoteConfig.admobIds;
        }
        break;
      case AppStartupStateRemoteConfigError():
      case AppStartupStateLoadingUserSession():
        break;
      case AppStartupStateLoadedUserSession():
        context.read<UserSessionProvider>().setUserSession = state.userSession;
        if (context.read<UserSessionProvider>().isLoggedIn ||
            !context.read<AppPrefsProvider>().appPrefs.appStartedForFirstTime)
          appRouterConfig.go(context, location: AppRouterPaths.MOVIES);
        else
          appRouterConfig.go(
            context,
            location: AppRouterPaths.LOGIN,
            extra: NavigationCategory.Forward,
          );
        break;
      case AppStartupStateUserSessionError():
        break;
    }
  }
}
