import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/ui/widgets/refresh_indicator_widget.dart';
import 'package:tmdb/features/main/tmdb/domain/entities/account_details_entity.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_bloc.dart';
import 'package:tmdb/features/main/tmdb/presentation/blocs/tmdb_event.dart';
import 'package:tmdb/features/main/tmdb/presentation/widgets/tmdb_items_widget.dart';
import 'package:tmdb/features/main/tmdb/presentation/widgets/tmdb_profile_widget.dart';

import '../../../../../core/ads/ad_utils.dart';
import '../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../core/ui/widgets/custom_filled_button_widget.dart';
import '../../../../../main.dart';
import '../../../../ads_manager/presentation/providers/ads_manager_provider.dart';
import '../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';

class TMDbbWidget extends StatelessWidget {
  final AccountDetailsEntity? accountDetails;

  const TMDbbWidget({super.key, this.accountDetails});

  void _signOut(BuildContext context) async {
    context.read<TMDbBloc>().add(const TMDbEventSignOut());
  }

  Widget _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TMDbProfileWidget(accountDetails: accountDetails),
            SizedBox(height: 28),
            const TMDbItemsWidget(),
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
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: BannerAdWidget(
                adUnitId: AdUtils.bannerAdId(
                  isIOS
                      ? context.read<AdsManagerProvider>().bannerAds!.tmdbIdIOS
                      : context.read<AdsManagerProvider>().bannerAds!.tmdbId,
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
    return Consumer<UserSessionProvider>(
      builder: (context, provider, _) {
        return provider.isLoggedIn
            ? RefreshIndicatorWidget(
              onRefresh: (completer) {
                context.read<TMDbBloc>().add(
                  TMDbEventRefreshAccountDetails(
                    provider.userSession.sessionId,
                    completer,
                  ),
                );
              },
              child: _bodyWidget(context),
            )
            : _bodyWidget(context);
      },
    );
  }
}
