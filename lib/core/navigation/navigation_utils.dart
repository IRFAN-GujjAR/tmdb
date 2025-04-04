// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:tmdb/core/common_features/data/api/celebs/celebrities_api.dart';
// import 'package:tmdb/core/navigation/navigation_page_constants.dart';
// import 'package:tmdb/core/utils/initialize_app.dart';
// import 'package:tmdb/features/app_startup/sub_features/user_session/domain/use_cases/user_session_store_use_case.dart';
// import 'package:tmdb/features/login/data/api/login_api_service.dart';
// import 'package:tmdb/features/login/data/data_sources/login_data_source.dart';
// import 'package:tmdb/features/login/data/repositories/login_repo_impl.dart';
// import 'package:tmdb/features/login/domain/use_cases/login_use_case.dart';
// import 'package:tmdb/features/login/presentation/blocs/login_bloc.dart';
// import 'package:tmdb/features/login/presentation/pages/login_page.dart';
// import 'package:tmdb/features/login/presentation/providers/login_provider.dart';
// import 'package:tmdb/features/main/celebrities/data/data_sources/celebrities_remote_data_source.dart';
// import 'package:tmdb/features/main/celebrities/data/repositories/celebrities_repo_impl.dart';
// import 'package:tmdb/features/main/celebrities/domain/use_cases/celebrities_use_case_load.dart';
// import 'package:tmdb/features/main/celebrities/presentation/blocs/celebrities_bloc.dart';
// import 'package:tmdb/features/main/celebrities/presentation/pages/celebrities_page.dart';
// import 'package:tmdb/features/main/home/presentation/providers/home_page_provider.dart';
// import 'package:tmdb/features/main/movies/data/data_sources/movies_remote_data_source.dart';
// import 'package:tmdb/features/main/movies/data/repositories/movies_repo_imp.dart';
// import 'package:tmdb/features/main/movies/domain/use_cases/movies_use_case_load.dart';
// import 'package:tmdb/features/main/movies/presentation/blocs/movies_bloc.dart';
// import 'package:tmdb/features/main/movies/presentation/blocs/movies_events.dart';
// import 'package:tmdb/features/main/movies/presentation/pages/movies_page.dart';
// import 'package:tmdb/features/main/search/search/presentation/pages/search_page.dart';
// import 'package:tmdb/features/main/search/trending_search/data/api/trending_search_api.dart';
// import 'package:tmdb/features/main/search/trending_search/data/data_sources/trending_search_remote_data_source.dart';
// import 'package:tmdb/features/main/search/trending_search/data/repositories/trending_search_repo_impl.dart';
// import 'package:tmdb/features/main/search/trending_search/domain/use_cases/trending_search_use_case_load.dart';
// import 'package:tmdb/features/main/search/trending_search/presentation/blocs/trending_search_bloc.dart';
// import 'package:tmdb/features/main/tmdb/presentation/pages/tmdb_page.dart';
// import 'package:tmdb/features/main/tv_shows/presentation/pages/tv_shows_page.dart';
// import 'package:tmdb/main.dart';
//
// import '../../features/app_startup/presentation/bloc/app_startup_bloc.dart';
// import '../../features/app_startup/presentation/pages/app_startup_page.dart';
// import '../../features/app_startup/presentation/providers/app_startup_provider.dart';
// import '../../features/app_startup/sub_features/remote_config/data/data_sources/remote_config_data_source.dart';
// import '../../features/app_startup/sub_features/remote_config/data/repositories/remote_config_repo_impl.dart';
// import '../../features/app_startup/sub_features/remote_config/domain/use_cases/remote_config_use_case.dart';
// import '../../features/app_startup/sub_features/env_variables/data/data_sources/env_variables_data_source.dart';
// import '../../features/app_startup/sub_features/env_variables/data/repositories/env_variables_repo_impl.dart';
// import '../../features/app_startup/sub_features/env_variables/domain/use_cases/env_variables_use_case.dart';
// import '../../features/app_startup/sub_features/user_session/data/data_sources/user_session_data_source.dart';
// import '../../features/app_startup/sub_features/user_session/data/repositories/user_session_repo_impl.dart';
// import '../../features/app_startup/sub_features/user_session/domain/use_cases/user_session_load_use_case.dart';
// import '../../features/main/home/presentation/pages/home_page.dart';
// import '../../features/main/tv_shows/data/data_sources/tv_shows_remote_data_source.dart';
// import '../../features/main/tv_shows/data/repositories/tv_shows_repo_impl.dart';
// import '../../features/main/tv_shows/domain/use_cases/tv_shows_use_case_load.dart';
// import '../../features/main/tv_shows/presentation/blocs/tv_shows_bloc.dart';
// import '../common_features/data/api/movie/movie_api.dart';
// import '../common_features/data/api/tv_show/tv_show_api.dart';
//
// part 'navigation_page.dart';
// part 'pages/app_startup_page.dart';
// part 'pages/celebrities/celebrities_page.dart';
// part 'pages/login_page.dart';
// part 'pages/movies/movies_page.dart';
// part 'pages/search/search_page.dart';
// part 'pages/tmdb/tmdb_page.dart';
// part 'pages/tv_shows/tv_shows_page.dart';
//
// class NavigationUtils {
//   static void navigate(
//       {required BuildContext context,
//       bool rootNavigator = false,
//       Widget? page,
//       NavigationPageType? pageType,
//       bool removePreviousPages = false,
//       bool replacePage = false,
//       bool fullScreenDialog = false,
//       bool useExistingDependencies = false}) {
//     if (page == null && pageType == null) {
//       throw ('Both Page and PageType cannot be null');
//     }
//     if (pageType != null) {
//       page = getNavigationPage(
//           pageType: pageType, useExistingDependencies: useExistingDependencies);
//     }
//     final route = isIOS
//         ? CupertinoPageRoute(
//             fullscreenDialog: fullScreenDialog,
//             builder: (_) => rootNavigator
//                 ? CupertinoTheme(
//                     data: CupertinoTheme.of(context),
//                     child: page!,
//                   )
//                 : page!)
//         : MaterialPageRoute(
//             fullscreenDialog: fullScreenDialog, builder: (_) => page!);
//     if (removePreviousPages) {
//       Navigator.of(context, rootNavigator: rootNavigator)
//           .pushAndRemoveUntil(route, (route) => false);
//     } else if (replacePage) {
//       Navigator.of(context, rootNavigator: rootNavigator)
//           .pushReplacement(route);
//     } else {
//       Navigator.of(context, rootNavigator: rootNavigator).push(route);
//     }
//   }
//
//   static void navigateToRoot(BuildContext context) {
//     var navigator = Navigator.of(context);
//     while (navigator.canPop()) {
//       navigator.pop();
//     }
//   }
//
//   static void navigateBack(BuildContext context, int numberOfScreens) {
//     int count = 1;
//     Navigator.of(context).popUntil((_) => count++ >= numberOfScreens);
//   }
//
//   static Widget getNavigationPage(
//       {required NavigationPageType pageType,
//       bool useExistingDependencies = false}) {
//     return _getNavigationPage(
//         pageType: pageType, useExistingDependencies: useExistingDependencies);
//   }
// }
