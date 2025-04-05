import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import '../../../../../core/router/routes/app_router_paths.dart';
import '../../../../../core/ui/dialogs/dialogs_utils.dart';
import '../../../../../core/ui/initialize_app.dart';
import '../../../../../core/ui/widgets/custom_list_tile_widget.dart';
import '../../../../../core/ui/widgets/custom_tonal_button_widget.dart';
import '../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import '../../../../login/presentation/pages/login_page.dart';

class TMDbItemsWidget extends StatelessWidget {
  const TMDbItemsWidget({super.key});

  void _navigateToTMDbMediaList(
    BuildContext context,
    TMDbMediaListCFCategory category,
  ) {
    if (context.read<UserSessionProvider>().isLoggedIn) {
      appRouterConfig.push(
        context,
        location: AppRouterPaths.TMDb_MEDIA_LIST_LOCATION,
        extra: category,
      );
    } else {
      DialogUtils.showMessageDialog(
        context,
        'You are not signed in. Please sign into to your TMDb account',
      );
    }
  }

  void _navigateToLogin(BuildContext context) {
    appRouterConfig.push(
      context,
      location: AppRouterPaths.LOGIN,
      extra: NavigationCategory.BackWard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Consumer<UserSessionProvider>(
          builder:
              (context, loginInfoProvider, _) =>
                  !loginInfoProvider.isLoggedIn
                      ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: CustomTonalButtonWidget(
                          onPressed: () => _navigateToLogin(context),
                          child: const Text('Sign In / Sign Up'),
                        ),
                      )
                      : Container(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomListTileWidget(
            title: 'Favourite',
            subtitle: 'Your favorites Movies & Tv Shows',
            icon: Icons.favorite_border,
            onPressed:
                () => _navigateToTMDbMediaList(
                  context,
                  TMDbMediaListCFCategory.favorites,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomListTileWidget(
            title: 'WatchList',
            subtitle: 'Movies and TvShows Added to watchlist',
            icon: Icons.bookmark_border,
            onPressed:
                () => _navigateToTMDbMediaList(
                  context,
                  TMDbMediaListCFCategory.watchlist,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomListTileWidget(
            title: 'Ratings',
            subtitle: 'Rated Movies & Tv Shows',
            icon: Icons.star_outline,
            onPressed:
                () => _navigateToTMDbMediaList(
                  context,
                  TMDbMediaListCFCategory.ratings,
                ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomListTileWidget(
            title: 'Appearances',
            subtitle: 'Set Light & Dark Theme',
            icon: Icons.settings_display,
            onPressed: () {
              appRouterConfig.push(
                context,
                location: AppRouterPaths.APPEARANCES_LOCATION,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: CustomListTileWidget(
            title: 'About',
            subtitle: 'Information about this app',
            icon: Icons.info,
            onPressed: () {
              appRouterConfig.push(
                context,
                location: AppRouterPaths.ABOUT_LOCATION,
              );
            },
          ),
        ),
      ],
    );
  }
}
