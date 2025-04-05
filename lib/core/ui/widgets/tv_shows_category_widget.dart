import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/ui/widgets/list/media_items_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';
import 'package:tmdb/core/ui/widgets/text_row_widget.dart';
import 'package:tmdb/core/ui/widgets/tv_poster_placeholder_widget.dart';
import 'package:tmdb/features/ads_manager/presentation/providers/ads_manager_provider.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/data/function_params/tv_shows_list_cf_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/data/function_params/tv_shows_list_cf_params_data.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/presentation/pages/extra/see_all_tv_shows_page_extra.dart';

import '../../../features/main/tv_shows/sub_features/details/presentation/pages/extra/tv_show_details_page_extra.dart';
import '../../../main.dart';
import '../../ads/ad_utils.dart';
import '../../entities/tv_show/tv_show_entity.dart';
import '../../router/routes/app_router_paths.dart';
import '../initialize_app.dart';
import '../screen_utils.dart';
import '../utils.dart';
import 'banner_ad_widget.dart';
import 'divider_widget.dart';
import 'list/params/config/media_items_horizontal_config.dart';

class TvShowsCategoryWidget extends StatelessWidget {
  final TvShowsCategories category;
  final TvShowsListEntity tvShowsList;
  final int? tvId;

  const TvShowsCategoryWidget({
    super.key,
    required this.category,
    required this.tvShowsList,
    this.tvId,
  });

  void _navigateToTvShowDetails(BuildContext context, TvShowEntity tvShow) {
    appRouterConfig.push(
      context,
      location: AppRouterPaths.TV_SHOW_DETAILS,
      extra: TvShowDetailsPageExtra(
        id: tvShow.id,
        tvShowTitle: tvShow.name,
        posterPath: tvShow.posterPath,
        backdropPath: tvShow.backdropPath,
      ),
    );
  }

  void _navigateToSeeAllTvShows(BuildContext context) {
    if ((category == TvShowsCategories.DetailsRecommended ||
            category == TvShowsCategories.DetailsSimilar) &&
        tvId == null) {
      throw ('Tv Id cannot be null');
    }
    appRouterConfig.push(
      context,
      location: AppRouterPaths.SEE_ALL_TV_SHOWS,
      extra: SeeAllTvShowsPageExtra(
        pageTitle: tvShowsCategoryName[category]!,
        tvShowsList: tvShowsList,
        cfParams:
            TvShowsListCFParams(
              category: TvShowsCFCategory.list,
              data: TvShowsListCFParamsData(
                listCategory: category.cfCategory,
                pageNo: 1,
                tvId: tvId,
              ),
            ).toJson(),
      ),
    );
  }

  Widget get _divider {
    if (category == TvShowsCategories.Popular) return Container();
    return DividerWidget(topPadding: _getDividerMargin);
  }

  double get _getDividerMargin {
    double topPadding = 0.0;
    switch (category) {
      case TvShowsCategories.AiringToday:
      case TvShowsCategories.TopRated:
      case TvShowsCategories.DetailsRecommended:
        topPadding = 12.0;
        break;
      case TvShowsCategories.Trending:
      case TvShowsCategories.DetailsSimilar:
        topPadding = 10.0;
        break;
      default:
        topPadding = 20.0;
        break;
    }
    return topPadding;
  }

  Widget _buildTopRatedItems(BuildContext context, TvShowEntity tvShow) {
    return GestureDetector(
      onTap: () {
        _navigateToTvShowDetails(context, tvShow);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 0, style: BorderStyle.none),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
              ),
              child:
                  tvShow.posterPath == null
                      ? TvPosterPlaceholderWidget(size: 24)
                      : Image.network(
                        'https://image.tmdb.org/t/p/w92' + tvShow.posterPath!,
                        fit: BoxFit.fitWidth,
                      ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    tvShow.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: 190,
                  margin: const EdgeInsets.only(left: 8.0, top: 4),
                  child: Text(
                    getTvShowsGenres(tvShow.genreIds)!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(CupertinoIcons.forward, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRatedTvShows(BuildContext context) {
    final List<TvShowEntity> tvShows = tvShowsList.tvShows;
    List<TvShowEntity>? firstPairTvShows;
    List<TvShowEntity>? secondPairTvShows;
    List<TvShowEntity>? thirdPairTvShows;

    for (int i = 0; i < 12; i++) {
      if (i >= 0 && i <= 3) {
        if (firstPairTvShows == null) {
          firstPairTvShows = [tvShows[i]];
        } else {
          firstPairTvShows.add(tvShows[i]);
        }
      } else if (i >= 4 && i <= 7) {
        if (secondPairTvShows == null) {
          secondPairTvShows = [tvShows[i]];
        } else {
          secondPairTvShows.add(tvShows[i]);
        }
      } else if (i >= 8 && i <= 11) {
        if (thirdPairTvShows == null) {
          thirdPairTvShows = [tvShows[i]];
        } else {
          thirdPairTvShows.add(tvShows[i]);
        }
      }
    }

    return Column(
      children: [
        TextRowWidget(
          categoryName: tvShowsCategoryName[category]!,
          showSeeAllBtn: true,
          onPressed: () => _navigateToSeeAllTvShows(context),
        ),
        Container(
          height: 200,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int mainIndex) {
              return Container(
                margin: EdgeInsets.only(left: PagePadding.leftPadding),
                width: 310,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      0,
                      firstPairTvShows,
                      secondPairTvShows,
                      thirdPairTvShows,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      1,
                      firstPairTvShows,
                      secondPairTvShows,
                      thirdPairTvShows,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      2,
                      firstPairTvShows,
                      secondPairTvShows,
                      thirdPairTvShows,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      3,
                      firstPairTvShows,
                      secondPairTvShows,
                      thirdPairTvShows,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(width: 8);
            },
            itemCount: 3,
          ),
        ),
        _divider,
      ],
    );
  }

  Widget _getTopRatedItems(
    BuildContext context,
    int mainIndex,
    int itemIndex,
    List<TvShowEntity>? firstPairMovies,
    List<TvShowEntity>? secondPairMovies,
    List<TvShowEntity>? thirdPairMovies,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTopRatedItems(context, firstPairMovies![itemIndex]);
      case 1:
        return _buildTopRatedItems(context, secondPairMovies![itemIndex]);
      case 2:
        return _buildTopRatedItems(context, thirdPairMovies![itemIndex]);
    }
    return Container();
  }

  Widget _buildTextRow(BuildContext context) {
    return TextRowWidget(
      categoryName: tvShowsCategoryName[category]!,
      showSeeAllBtn: true,
      onPressed: () {
        _navigateToSeeAllTvShows(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (category == TvShowsCategories.TopRated)
      return _buildTopRatedTvShows(context);

    _TvShowsItemConfiguration tvShowsItemConfiguration =
        _TvShowsItemConfiguration(category: category);

    int font = 12;
    if (category == TvShowsCategories.AiringToday) {
      font = 15;
    } else {
      font = 12;
    }

    return Column(
      children: [
        if (category == TvShowsCategories.DetailsSimilar ||
            category == TvShowsCategories.DetailsRecommended)
          _divider,
        _buildTextRow(context),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromTvShows(
            tvShows: tvShowsList.tvShows,
            previousPageTitle: 'Tv Shows',
            isLandscape: category == TvShowsCategories.AiringToday,
            config: MediaItemsHorizontalConfig(
              listViewHeight: tvShowsItemConfiguration.listViewHeight,
              listItemWidth: tvShowsItemConfiguration.listItemWidth,
              imageHeight: tvShowsItemConfiguration.imageHeight,
              font: font.toDouble(),
              posterSize: tvShowsItemConfiguration.posterSize,
              backdropSize: tvShowsItemConfiguration.backdropSize,
            ),
          ),
        ),
        if (!(category == TvShowsCategories.DetailsRecommended ||
            category == TvShowsCategories.DetailsSimilar))
          !isIOS && category == TvShowsCategories.AiringToday
              ? Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                child: BannerAdWidget(
                  showDivider: true,
                  adUnitId: AdUtils.bannerAdId(
                    context.read<AdsManagerProvider>().bannerAds!.tvShowsId,
                  ),
                  adSize: AdSize.banner,
                ),
              )
              : _divider,
      ],
    );
  }
}

class _TvShowsItemConfiguration {
  final TvShowsCategories category;
  late double listViewHeight;
  late double imageHeight;
  late double listItemWidth;
  PosterSizes posterSize = PosterSizes.w185;
  BackdropSizes backdropSize = BackdropSizes.w300;

  _TvShowsItemConfiguration({required this.category}) {
    _initializeAllValues(category);
  }

  _initializeAllValues(TvShowsCategories tvShowsCategory) {
    switch (tvShowsCategory) {
      case TvShowsCategories.AiringToday:
        listViewHeight = 170;
        imageHeight = 122;
        listItemWidth = 209;
        backdropSize = BackdropSizes.w300;
        break;
      case TvShowsCategories.Trending:
        listViewHeight = 200;
        imageHeight = 139;
        listItemWidth = 99;
        posterSize = PosterSizes.w185;
        break;
      case TvShowsCategories.TopRated:
        listViewHeight = 240;
        imageHeight = 180;
        listItemWidth = 120;
        posterSize = PosterSizes.w92;
        break;
      case TvShowsCategories.Popular:
        listViewHeight = 220;
        imageHeight = 150;
        listItemWidth = 107;
        posterSize = PosterSizes.w185;
        break;
      case TvShowsCategories.DetailsRecommended:
      case TvShowsCategories.DetailsSimilar:
        listViewHeight = 205;
        imageHeight = 139;
        listItemWidth = 99;
        posterSize = PosterSizes.w185;
        break;
    }
  }

  // String get imageSize {
  //   switch (category) {
  //     case TvShowsCategories.AiringToday:
  //       return BackDropSizes.w300;
  //     case TvShowsCategories.TopRated:
  //       return PosterSizes.w92;
  //     case TvShowsCategories.Trending:
  //     case TvShowsCategories.Popular:
  //     case TvShowsCategories.DetailsRecommended:
  //     case TvShowsCategories.DetailsSimilar:
  //       return PosterSizes.w185;
  //   }
  // }
}
