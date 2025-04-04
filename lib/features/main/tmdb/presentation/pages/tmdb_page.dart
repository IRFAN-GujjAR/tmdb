import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/dialogs/dialogs_utils.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_filled_button_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_tonal_button_widget.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/login/presentation/blocs/login_status/login_status_bloc.dart';
import 'package:tmdb/features/login/presentation/pages/login_page.dart';
import 'package:tmdb/main.dart';

import '../../../../../core/ads/ad_utils.dart';
import '../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../core/ui/widgets/custom_list_tile_widget.dart';

class TMDbPage extends StatelessWidget {
  const TMDbPage({Key? key}) : super(key: key);

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
      showUserIsNotLoggedIn(context);
    }
  }

  void showUserIsNotLoggedIn(BuildContext context) {
    DialogUtils.showMessageDialog(
      context,
      'You are not signed in. Please sign into to your TMDb account',
    );
  }

  Widget _buildBodyItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
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
        ],
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await Provider.of<UserSessionProvider>(context, listen: false).delete;
    context.read<LoginStatusBloc>().add(LoginStatusEventLogout());
  }

  void _navigateToLogin(BuildContext context) {
    appRouterConfig.push(
      context,
      location: AppRouterPaths.LOGIN,
      extra: NavigationCategory.BackWard,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10),
                Icon(Icons.account_circle, size: 40),
                SizedBox(width: 10),
                Consumer<UserSessionProvider>(
                  builder:
                      (context, provider, _) => Text(
                        provider.isLoggedIn
                            ? provider.userSession.username
                            : 'Your Account',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 28,
                        ),
                      ),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildBodyItems(context),
            SizedBox(height: 20),
            Consumer<UserSessionProvider>(
              builder:
                  (context, loginInfoProvider, _) =>
                      loginInfoProvider.isLoggedIn
                          ? CustomFilledButtonWidget(
                            onPressed: () {
                              _signOut(context);
                            },
                            child: Text('Sign out'),
                          )
                          : Container(),
            ),
            if (!isIOS)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: BannerAdWidget(
                  adUnitId: AdUtils.bannerAdId(
                    context.read<AdsManagerProvider>().bannerAds!.tmdbId,
                  ),
                  adSize: AdSize.largeBanner,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CustomBodyWidget(child: _buildBody(context)));
  }
}
