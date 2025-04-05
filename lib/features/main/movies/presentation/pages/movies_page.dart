import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/ads/ad_utils.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/core/ui/widgets/refresh_indicator_widget.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/main/movies/domain/entities/movies_entity.dart';
import 'package:tmdb/features/main/movies/presentation/blocs/movies_bloc.dart';
import 'package:tmdb/features/main/movies/presentation/blocs/movies_events.dart';
import 'package:tmdb/features/main/movies/presentation/blocs/movies_states.dart';
import 'package:tmdb/main.dart';

import '../../../../../core/ui/utils.dart';
import '../../../../../core/ui/widgets/banner_ad_widget.dart';
import '../../../../../core/ui/widgets/custom_error_widget.dart';
import '../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../core/ui/widgets/movies_category_widget.dart';
import '../../../home/presentation/pages/home_page.dart';

final class MoviesPage extends StatelessWidget {
  MoviesPage({super.key});

  Widget _bodyWidget(BuildContext context, MoviesEntity movies) {
    return RefreshIndicatorWidget(
      onRefresh: (completer) {
        context.read<MoviesBloc>().add(MoviesEventRefresh(completer));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: PagePadding.topPadding,
          bottom: PagePadding.bottomPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            MoviesCategoriesWidget(
              category: MoviesCategories.Popular,
              moviesList: movies.popular,
            ),
            if (!isIOS)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: BannerAdWidget(
                  showDivider: true,
                  adUnitId: AdUtils.bannerAdId(
                    context.read<AdsManagerProvider>().bannerAds!.moviesId,
                  ),
                  adSize: AdSize.banner,
                ),
              ),
            MoviesCategoriesWidget(
              category: MoviesCategories.InTheatres,
              moviesList: movies.inTheatres,
            ),
            MoviesCategoriesWidget(
              category: MoviesCategories.Trending,
              moviesList: movies.trending,
            ),
            MoviesCategoriesWidget(
              category: MoviesCategories.TopRated,
              moviesList: movies.topRated,
            ),
            MoviesCategoriesWidget(
              category: MoviesCategories.Upcoming,
              moviesList: movies.upComing,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildMoviesWidget {
    return BlocConsumer<MoviesBloc, MoviesState>(
      listener: (context, state) {
        if (state is MoviesStateErrorWithCache) {
          UIUtl.showSnackBar(context, msg: state.error.error.errorMessage);
        }
      },
      builder: (context, state) {
        switch (state) {
          case MoviesStateLoading():
            return LoadingWidget();
          case MoviesStateLoaded():
            return _bodyWidget(context, state.movies);
          case MoviesStateErrorWithCache():
            return _bodyWidget(context, state.movies);
          case MoviesStateErrorWithoutCache():
            return CustomErrorWidget(
              error: state.error,
              onPressed:
                  () => context.read<MoviesBloc>().add(MoviesEventLoad()),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tabName[TabItem.movies]!)),
      body: SafeArea(child: _buildMoviesWidget),
    );
  }
}
