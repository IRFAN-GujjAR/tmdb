import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';
import 'package:tmdb/core/ui/widgets/list/celebrity_items_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/media_items_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_items_params.dart';
import 'package:tmdb/core/ui/widgets/list/params/config/celebrity_item_config.dart';
import 'package:tmdb/core/ui/widgets/list/params/config/media_items_horizontal_config.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';
import 'package:tmdb/core/ui/widgets/text_row_widget.dart';
import 'package:tmdb/features/main/search/details/presentation/providers/search_details_provider.dart';

class AllSearchWidget extends StatefulWidget {
  final MoviesListEntity moviesList;
  final TvShowsListEntity tvShowsList;
  final CelebritiesListEntity celebritiesList;

  AllSearchWidget({
    required this.moviesList,
    required this.tvShowsList,
    required this.celebritiesList,
  });

  @override
  State<AllSearchWidget> createState() => _AllSearchWidgetState();
}

class _AllSearchWidgetState extends State<AllSearchWidget>
    with AutomaticKeepAliveClientMixin<AllSearchWidget> {
  Widget _buildCelebritiesWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TextRowWidget(
          categoryName: 'Celebrities',
          showSeeAllBtn: true,
          onPressed: () {
            context.read<SearchDetailsProvider>().changeTabControllerIndex(3);
          },
        ),
        CelebrityItemsHorizontalWidget(
          CelebrityItemsParams.fromCelebs(
            widget.celebritiesList.celebrities,
            config: CelebrityItemConfig(
              listViewHeight: 220,
              listItemWidth: 100,
              imageHeight: 130,
              font: 12,
              profileSize: ProfileSizes.w185,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTvShowsWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TextRowWidget(
          categoryName: 'Tv Shows',
          showSeeAllBtn: true,
          onPressed: () {
            context.read<SearchDetailsProvider>().changeTabControllerIndex(2);
          },
        ),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromTvShows(
            tvShows: widget.tvShowsList.tvShows,
            previousPageTitle: 'Search',
            isLandscape: true,
            config: MediaItemsHorizontalConfig(
              listViewHeight: 170,
              listItemWidth: 209,
              imageHeight: 122,
              font: 15,
              posterSize: PosterSizes.w185,
              backdropSize: BackdropSizes.w300,
            ),
          ),
        ),
        DividerWidget(topPadding: 12.0),
      ],
    );
  }

  Widget _buildMoviesWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        TextRowWidget(
          categoryName: 'Movies',
          showSeeAllBtn: true,
          onPressed: () {
            context.read<SearchDetailsProvider>().changeTabControllerIndex(1);
          },
        ),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromMovies(
            movies: widget.moviesList.movies,
            previousPageTitle: 'Search',
            isLandscape: false,
            config: MediaItemsHorizontalConfig(
              listViewHeight: 220,
              listItemWidth: 107,
              imageHeight: 150,
              font: 13,
              posterSize: PosterSizes.w185,
              backdropSize: BackdropSizes.w300,
            ),
          ),
        ),
        DividerWidget(topPadding: 5.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: PagePadding.topPadding,
        bottom: PagePadding.bottomPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMoviesWidget(context),
          _buildTvShowsWidget(context),
          _buildCelebritiesWidget(context),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
