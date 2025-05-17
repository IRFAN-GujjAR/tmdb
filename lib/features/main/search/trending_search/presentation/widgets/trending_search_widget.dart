import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/entities/search/search_entity.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/refresh_indicator_widget.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/main/search/search/presentation/providers/search_bar_provider.dart';
import 'package:tmdb/features/main/search/trending_search/presentation/blocs/trending_search_bloc.dart';

import '../../../../../../core/ads/ad_utils.dart';
import '../../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../../main.dart';

class TrendingSearchWidget extends StatelessWidget {
  const TrendingSearchWidget({super.key});

  Widget _body(
    BuildContext context, {
    required List<SearchEntity> trendingSearches,
  }) {
    final length = (trendingSearches.length / 2).round() - 2;
    return RefreshIndicatorWidget(
      onRefresh: (completer) {
        context.read<TrendingSearchBloc>().add(
          TrendingSearchEventRefresh(completer),
        );
      },
      child: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
            final button = TextButton(
              onPressed: () {
                context.read<SearchBarProvider>().onTrendingItemPressed(
                  context,
                  trendingSearches[index].searchTitle,
                );
              },
              child: Text(
                trendingSearches[index].searchTitle,
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            );
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Trending', style: TextStyle(fontSize: 24)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: button,
                    ),
                  ],
                ),
              );
            }
            return index == length - 1
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    button,
                    SizedBox(height: 20),
                    BannerAdWidget(
                      adUnitId: AdUtils.bannerAdId(
                        isIOS
                            ? context
                                .read<AdsManagerProvider>()
                                .bannerAds!
                                .searchIdIOS
                            : context
                                .read<AdsManagerProvider>()
                                .bannerAds!
                                .searchId,
                      ),
                      adSize: AdSize.largeBanner,
                    ),
                    SizedBox(height: 20),
                  ],
                )
                : Column(children: [button]);
          },
          itemCount: length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrendingSearchBloc, TrendingSearchState>(
      listener: (context, state) {
        if (state is TrendingSearchStateErrorWithCache) {
          UIUtl.showSnackBar(context, msg: state.error.error.errorMessage);
        }
      },
      builder: (context, state) {
        switch (state) {
          case TrendingSearchStateLoading():
            return LoadingWidget();
          case TrendingSearchStateLoaded():
            return _body(
              context,
              trendingSearches: state.trendingSearch.searches,
            );
          case TrendingSearchStateErrorWithCache():
            return _body(
              context,
              trendingSearches: state.trendingSearch.searches,
            );
          case TrendingSearchStateErrorWithoutCache():
            return CustomErrorWidget(
              error: state.error,
              onPressed:
                  () => context.read<TrendingSearchBloc>().add(
                    TrendingSearchEventLoad(),
                  ),
            );
        }
      },
    );
  }
}
