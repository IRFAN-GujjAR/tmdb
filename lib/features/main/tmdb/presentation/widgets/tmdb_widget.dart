import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_bloc.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_event.dart';

import '../../../../../core/ads/ad_utils.dart';
import '../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import '../../../../../core/router/routes/app_router_paths.dart';
import '../../../../../core/ui/dialogs/dialogs_utils.dart';
import '../../../../../core/ui/initialize_app.dart';
import '../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../core/ui/widgets/custom_filled_button_widget.dart';
import '../../../../../core/ui/widgets/custom_list_tile_widget.dart';
import '../../../../../core/ui/widgets/custom_tonal_button_widget.dart';
import '../../../../../main.dart';
import '../../../../ads_manager/presentation/providers/ads_manager_provider.dart';
import '../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import '../../../../login/presentation/pages/login_page.dart';

class TMDbbWidget extends StatelessWidget {
  final AccountDetailsEntity? accountDetails;

  const TMDbbWidget({super.key, this.accountDetails});

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
      ),
    );
  }

  void _signOut(BuildContext context) async {
    context.read<TMDbBloc>().add(const TMDbEventSignOut());
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
                Text(
                  accountDetails?.username ?? 'Your Name',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
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
}
