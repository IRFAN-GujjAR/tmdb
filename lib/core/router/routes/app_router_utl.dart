import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/repositories/remote_config_repo_impl.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/use_cases/remote_config_use_case.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/main/cast_crew/presentation/pages/see_all_cast_crew_page.dart';
import 'package:tmdb/features/main/celebrities/data/data_sources/celebrities_local_data_source.dart';
import 'package:tmdb/features/main/celebrities/data/db/dao/celebs_dao.dart';
import 'package:tmdb/features/main/celebrities/domain/use_cases/celebrities_use_case_watch.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/data_sources/celebrity_details_data_source.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/repositories/celebrity_details_repo_impl.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/movie_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/tv_show_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/use_cases/celebrity_details_use_case.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/blocs/celebrity_details_bloc.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/blocs/celebrity_details_event.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/celebrity_details_page.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/credits/see_all_movie_credits_page.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/photo/celebrity_photo_page.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/photo/extra/celebrity_photo_page_extra.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/data_sources/see_all_celebs_data_source.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/data/repositories/see_all_celebs_repo_impl.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/domain/use_cases/see_all_celebs_use_case.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/blocs/see_all_celebs_bloc.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/pages/extra/see_all_celebs_page_extra.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/pages/see_all_celebs_page.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/providers/see_all_celebs_provider.dart';
import 'package:tmdb/features/main/home/presentation/providers/home_page_provider.dart';
import 'package:tmdb/features/main/movies/data/data_sources/movies_local_data_source.dart';
import 'package:tmdb/features/main/movies/domain/use_cases/movies_use_case_watch.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/data_sources/movie_details_data_source.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/repositories/movie_details_repo_impl.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/use_cases/movie_details_use_case.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/blocs/movie_details_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/pages/extra/movie_details_page_extra.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/pages/movie_details_page.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/data_sources/see_all_movies_data_source.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/repositories/see_all_movies_repo_impl.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/domain/use_cases/see_all_movies_use_case.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/blocs/see_all_movies_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/pages/extra/see_all_movies_page_extra.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/providers/see_all_movies_provider.dart';
import 'package:tmdb/features/main/search/details/data/data_sources/search_details_data_source.dart';
import 'package:tmdb/features/main/search/details/data/repositories/search_details_repo_impl.dart';
import 'package:tmdb/features/main/search/details/domain/use_cases/search_details_use_case.dart';
import 'package:tmdb/features/main/search/details/presentation/blocs/search_details_bloc.dart';
import 'package:tmdb/features/main/search/details/presentation/providers/search_details_provider.dart';
import 'package:tmdb/features/main/search/search/data/data_sources/search_data_source.dart';
import 'package:tmdb/features/main/search/search/data/repositories/search_repo_impl.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/search_use_case.dart';
import 'package:tmdb/features/main/search/search/presentation/blocs/search_bloc.dart';
import 'package:tmdb/features/main/search/search/presentation/providers/search_bar_provider.dart';
import 'package:tmdb/features/main/search/trending_search/data/data_sources/trending_search_local_data_source.dart';
import 'package:tmdb/features/main/search/trending_search/data/db/dao/trending_search_dao.dart';
import 'package:tmdb/features/main/search/trending_search/domain/use_cases/trending_search_use_case_watch.dart';
import 'package:tmdb/features/main/tmdb/sub_features/appearances/presentation/pages/appearances_page.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_provider.dart';
import 'package:tmdb/features/main/tv_shows/data/data_sources/tv_shows_local_data_source.dart';
import 'package:tmdb/features/main/tv_shows/data/db/dao/tv_shows_dao.dart';
import 'package:tmdb/features/main/tv_shows/domain/use_cases/tv_shows_use_case_watch.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/data_sources/tv_show_season_details_data_source.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/repositories/tv_show_season_details_repo_impl.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/params/tv_show_season_details_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/tv_show_season_details_use_case.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/blocs/tv_show_season_details_bloc.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/see_all_seasons_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/tv_show_season_details_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/see_all_seasons_page.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/tv_show_season_details_page.dart';
import 'package:tmdb/features/media_state/data/data_sources/media_state_data_source.dart';
import 'package:tmdb/features/media_state/data/repositories/media_state_repo_impl.dart';
import 'package:tmdb/features/media_state/domain/use_cases/media_state_use_case.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/data_sources/rate_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/repositories/rate_media_repo_impl.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/providers/rate_provider.dart';

import '../../../features/app_startup/presentation/bloc/app_startup_bloc.dart';
import '../../../features/app_startup/presentation/pages/app_startup_page.dart';
import '../../../features/app_startup/presentation/providers/app_startup_provider.dart';
import '../../../features/app_startup/sub_features/remote_config/data/data_sources/remote_config_data_source.dart';
import '../../../features/app_startup/sub_features/user_session/data/data_sources/user_session_data_source.dart';
import '../../../features/app_startup/sub_features/user_session/data/repositories/user_session_repo_impl.dart';
import '../../../features/app_startup/sub_features/user_session/domain/use_cases/user_session_load_use_case.dart';
import '../../../features/app_startup/sub_features/user_session/domain/use_cases/user_session_store_use_case.dart';
import '../../../features/login/data/data_sources/login_data_source.dart';
import '../../../features/login/data/repositories/login_repo_impl.dart';
import '../../../features/login/domain/use_cases/login_use_case.dart';
import '../../../features/login/presentation/blocs/login_bloc.dart';
import '../../../features/login/presentation/pages/login_page.dart';
import '../../../features/login/presentation/providers/login_provider.dart';
import '../../../features/main/celebrities/data/data_sources/celebrities_remote_data_source.dart';
import '../../../features/main/celebrities/data/repositories/celebrities_repo_impl.dart';
import '../../../features/main/celebrities/domain/use_cases/celebrities_use_case_load.dart';
import '../../../features/main/celebrities/presentation/blocs/celebrities_bloc.dart';
import '../../../features/main/celebrities/presentation/pages/celebrities_page.dart';
import '../../../features/main/celebrities/sub_features/details/presentation/pages/credits/see_all_tv_credits_page.dart';
import '../../../features/main/home/presentation/pages/home_page.dart';
import '../../../features/main/movies/data/data_sources/movies_remote_data_source.dart';
import '../../../features/main/movies/data/db/dao/movies_dao.dart';
import '../../../features/main/movies/data/repositories/movies_repo_imp.dart';
import '../../../features/main/movies/domain/use_cases/movies_use_case_load.dart';
import '../../../features/main/movies/presentation/blocs/movies_bloc.dart';
import '../../../features/main/movies/presentation/blocs/movies_events.dart';
import '../../../features/main/movies/presentation/pages/movies_page.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/data/data_sources/movie_collection_details_data_source.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/data/repositories/movie_collection_details_repo_impl.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/domain/use_cases/movie_collection_details_use_case.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/presentation/blocs/bloc/movie_collection_details_bloc.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/presentation/pages/extra/movie_collection_details_page_extra.dart';
import '../../../features/main/movies/sub_features/details/sub_features/collection/presentation/pages/movie_collection_details_page.dart';
import '../../../features/main/movies/sub_features/see_all/presentation/pages/see_all_movies_page.dart';
import '../../../features/main/search/search/presentation/pages/search_page.dart';
import '../../../features/main/search/trending_search/data/data_sources/trending_search_remote_data_source.dart';
import '../../../features/main/search/trending_search/data/repositories/trending_search_repo_impl.dart';
import '../../../features/main/search/trending_search/domain/use_cases/trending_search_use_case_load.dart';
import '../../../features/main/search/trending_search/presentation/blocs/trending_search_bloc.dart';
import '../../../features/main/tmdb/presentation/pages/tmdb_page.dart';
import '../../../features/main/tmdb/sub_features/media_list/data/data_sources/tmdb_media_list_data_source.dart';
import '../../../features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';
import '../../../features/main/tmdb/sub_features/media_list/data/repositories/tmdb_media_list_repo_impl.dart';
import '../../../features/main/tmdb/sub_features/media_list/domain/usecases/tmdb_media_list_usecase.dart';
import '../../../features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_bloc.dart';
import '../../../features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_event.dart';
import '../../../features/main/tmdb/sub_features/media_list/presentation/pages/tmdb_media_list_page.dart';
import '../../../features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_scroll_controller_provider.dart';
import '../../../features/main/tv_shows/data/data_sources/tv_shows_remote_data_source.dart';
import '../../../features/main/tv_shows/data/repositories/tv_shows_repo_impl.dart';
import '../../../features/main/tv_shows/domain/use_cases/tv_shows_use_case_load.dart';
import '../../../features/main/tv_shows/presentation/blocs/tv_shows_bloc.dart';
import '../../../features/main/tv_shows/presentation/pages/tv_shows_page.dart';
import '../../../features/main/tv_shows/sub_features/details/data/data_sources/tv_show_details_data_source.dart';
import '../../../features/main/tv_shows/sub_features/details/data/repositories/tv_show_details_repo_impl.dart';
import '../../../features/main/tv_shows/sub_features/details/domain/use_cases/tv_show_details_use_case.dart';
import '../../../features/main/tv_shows/sub_features/details/presentation/blocs/tv_show_details_bloc.dart';
import '../../../features/main/tv_shows/sub_features/details/presentation/pages/extra/tv_show_details_page_extra.dart';
import '../../../features/main/tv_shows/sub_features/details/presentation/pages/tv_shows_details_page.dart';
import '../../../features/main/tv_shows/sub_features/see_all/data/data_sources/see_all_tv_shows_data_source.dart';
import '../../../features/main/tv_shows/sub_features/see_all/data/repositories/see_all_tv_shows_repo_impl.dart';
import '../../../features/main/tv_shows/sub_features/see_all/domain/use_cases/see_all_tv_shows_use_case.dart';
import '../../../features/main/tv_shows/sub_features/see_all/presentation/blocs/see_all_tv_shows_bloc.dart';
import '../../../features/main/tv_shows/sub_features/see_all/presentation/pages/extra/see_all_tv_shows_page_extra.dart';
import '../../../features/main/tv_shows/sub_features/see_all/presentation/pages/see_all_tv_shows_page.dart';
import '../../../features/main/tv_shows/sub_features/see_all/presentation/providers/see_all_tv_shows_provider.dart';
import '../../../features/media_state/sub_features/media_tmdb/rate/presentation/pages/extra/rate_page_extra.dart';
import '../../../features/media_state/sub_features/media_tmdb/rate/presentation/pages/rate_page.dart';
import '../../firebase/cloud_functions/categories/sort_by_cf_category.dart';
import '../../firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import '../../firebase/cloud_functions/categories/tmdb/tmdb_media_list_type_cf_category.dart';
import 'app_router_nav_keys.dart';
import 'app_router_paths.dart';

part 'pages/app_startup_page.dart';
part 'pages/celebrities/celebrities_page.dart';
part 'pages/celebrities/celebrity_details_page.dart';
part 'pages/celebrities/see_all_celebs_page.dart';
part 'pages/login_page.dart';
part 'pages/movies/movie_collection_details_page.dart';
part 'pages/movies/movie_details_page.dart';
part 'pages/movies/movies_page.dart';
part 'pages/movies/see_all_movies_page.dart';
part 'pages/rate_page.dart';
part 'pages/search/search_page.dart';
part 'pages/tmdb/tmdb_media_list_page.dart';
part 'pages/tmdb/tmdb_page.dart';
part 'pages/tv_shows/see_all_tv_shows_page.dart';
part 'pages/tv_shows/tv_show_details_page.dart';
part 'pages/tv_shows/tv_show_season_details_page.dart';
part 'pages/tv_shows/tv_shows_page.dart';

final class AppRouterUtl {
  GoRouter appRouter({required AppRouterNavKeys navKeys}) => GoRouter(
    navigatorKey: navKeys.rootNavKey,
    initialLocation: AppRouterPaths.INITIAL_LOCATION,
    routes: <RouteBase>[
      // #docregion configuration-builder
      GoRoute(
        path: AppRouterPaths.INITIAL_LOCATION,
        builder: (context, state) => _appStartupPage(context),
      ),
      GoRoute(
        path: AppRouterPaths.LOGIN,
        builder: (context, state) => _loginPage(context, state),
      ),
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) {
          // Return the widget that implements the custom shell (in this case
          // using a BottomNavigationBar). The StatefulNavigationShell is passed
          // to be able access the state of the shell and to navigate to other
          // branches in a stateful way.
          return ChangeNotifierProvider(
            create: (_) => HomePageProvider(),
            child: HomePage(navigationShell: navigationShell),
          );
        },
        // #enddocregion configuration-builder
        // #docregion configuration-branches
        branches: <StatefulShellBranch>[
          // The route branch for the first tab of the bottom navigation bar.
          StatefulShellBranch(
            navigatorKey: navKeys.moviesNavKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: AppRouterPaths.MOVIES,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _moviesPage(context),
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          // #enddocregion configuration-branches
          StatefulShellBranch(
            navigatorKey: navKeys.tvShowsNavKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: AppRouterPaths.TV_SHOWS,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _tvShowsPage(context),
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          StatefulShellBranch(
            navigatorKey: navKeys.celebritiesNavKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: AppRouterPaths.CELEBRITIES,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _celebritiesPage(context),
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          StatefulShellBranch(
            navigatorKey: navKeys.searchNavKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: AppRouterPaths.SEARCH,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _searchPage(context),
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          StatefulShellBranch(
            navigatorKey: navKeys.tMDBNavKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: AppRouterPaths.TMDb,
                builder:
                    (BuildContext context, GoRouterState state) => _tMDBPage,
                routes: [
                  GoRoute(
                    path: AppRouterPaths.APPEARANCES_NAME,
                    builder: (context, state) => const AppearancesPage(),
                  ),
                  GoRoute(
                    path: AppRouterPaths.TMDb_MEDIA_LIST_NAME,
                    builder:
                        (context, state) => _tMDBMediaListPage(context, state),
                  ),
                ],
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
          StatefulShellBranch(
            navigatorKey: navKeys.detailsNavKey,
            routes: <RouteBase>[
              GoRoute(
                path: AppRouterPaths.MOVIE_DETAILS,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _movieDetailsPage(context, state),
                routes: [
                  GoRoute(
                    path: AppRouterPaths.MOVIE_COLLECTION_DETAILS_NAME,
                    builder:
                        (context, state) =>
                            _movieCollectionDetailsPage(context, state),
                  ),
                ],
              ),
              GoRoute(
                path: AppRouterPaths.TV_SHOW_DETAILS,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _tvShowDetailsPage(context, state),
                routes: [
                  GoRoute(
                    path: AppRouterPaths.SEE_ALL_SEASONS_NAME,
                    builder:
                        (context, state) => SeeAllSeasonsPage(
                          state.extra as SeeAllSeasonsPageExtra,
                        ),
                  ),
                  GoRoute(
                    path: AppRouterPaths.TV_SHOW_SEASON_DETAILS_NAME,
                    builder:
                        (context, state) =>
                            _tvShowSeasonDetailsPage(context, state),
                  ),
                ],
              ),
              GoRoute(
                path: AppRouterPaths.CELEBRITY_DETAILS,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        _celebrityDetailsPage(context, state),
                routes: [
                  GoRoute(
                    path: AppRouterPaths.SEE_ALL_MOVIE_CREDITS_NAME,
                    builder:
                        (context, state) => SeeAllMovieCreditsPage(
                          movieCredits: state.extra as MovieCreditsEntity,
                        ),
                  ),
                  GoRoute(
                    path: AppRouterPaths.SEE_ALL_TV_CREDITS_NAME,
                    builder:
                        (context, state) => SeeAllTvCreditsPage(
                          tvCredits: state.extra as TvShowCreditsEntity,
                        ),
                  ),
                ],
              ),
              GoRoute(
                path: AppRouterPaths.SEE_ALL_MOVIES,
                builder: (context, state) => _seeAllMoviesPage(context, state),
              ),
              GoRoute(
                path: AppRouterPaths.SEE_ALL_TV_SHOWS,
                builder: (context, state) => _seeAllTvShowsPage(context, state),
              ),
              GoRoute(
                path: AppRouterPaths.SEE_ALL_CELEBS,
                builder: (context, state) => _seeAllCelebsPage(context, state),
              ),
              GoRoute(
                path: AppRouterPaths.SEE_ALL_CAST_CREW,
                builder:
                    (BuildContext context, GoRouterState state) =>
                        SeeAllCastCrewPage(
                          credits: state.extra as CreditsEntity,
                        ),
              ),
            ],
            // To enable preloading of the initial locations of branches, pass
            // 'true' for the parameter `preload` (false is default).
          ),
        ],
      ),
      GoRoute(
        path: AppRouterPaths.RATE,
        builder: (context, state) => _ratePage(context, state),
      ),
      GoRoute(
        path: AppRouterPaths.CELEBRITY_PHOTO,
        builder:
            (context, state) =>
                CelebrityPhotoPage(state.extra as CelebrityPhotoPageExtra),
      ),
    ],
  );
}
