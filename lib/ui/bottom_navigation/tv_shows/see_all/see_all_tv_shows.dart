import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_states.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/tv_shows/see_all/see_all_tv_shows_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

import '../../../../main.dart';
import '../tv_shows.dart';

class SeeAllTvShows extends StatefulWidget {
  final String previousPageTitle;
  final TvShowsCategories tvShowCategory;
  final TvShowsList tvShowsList;
  final int tvShowId;

  SeeAllTvShows(
      {@required this.previousPageTitle,
      @required this.tvShowCategory,
      @required this.tvShowsList,
      @required this.tvShowId});

  @override
  _SeeAllTvShowsState createState() => _SeeAllTvShowsState();
}

class _SeeAllTvShowsState extends State<SeeAllTvShows> {
  SeeAllTvShowsBloc _seeAllTvShowsBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    _seeAllTvShowsBloc = SeeAllTvShowsBloc(
        seeAllTvShowsRepo: SeeAllTvShowsRepo(client: getHttpClient(context)),
        tvShowsList: widget.tvShowsList);

    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllTvShowsBloc.state is SeeAllTvShowsLoadingMore)) {
        _getTvShows();
      }
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _scrollControllerUtil.dispose();
    _seeAllTvShowsBloc.close();
    super.dispose();
  }

  void _getTvShows() {
    String url = '';
    final tvShowsList = _seeAllTvShowsBloc.tvShowsList;
    if (tvShowsList.pageNumber < tvShowsList.totalPages) {
      final pageNumber = tvShowsList.pageNumber + 1;
      switch (widget.tvShowCategory) {
        case TvShowsCategories.AiringToday:
          url = URLS.airingTodayTvShows(pageNumber);
          break;
        case TvShowsCategories.Trending:
          url = URLS.trendingTvShows(pageNumber);
          break;
        case TvShowsCategories.TopRated:
          url = URLS.topRatedTvShows(pageNumber);
          break;
        case TvShowsCategories.Popular:
          url = URLS.popularTvShows(pageNumber);
          break;
        case TvShowsCategories.DetailsRecommended:
          url = URLS.recommendedTvShows(widget.tvShowId, pageNumber);
          break;
        case TvShowsCategories.DetailsSimilar:
          url = URLS.similarTvShows(widget.tvShowId, pageNumber);
          break;
      }
      _seeAllTvShowsBloc
          .add(LoadMoreSeeAllTvShows(previousTvShows: tvShowsList, url: url));
    }
  }

  void _navigateToTvShowDetails(
      int id, String movieTitle, TvShowsCategories category) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: tvShowsCategoryName[category],
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: tvShowsCategoryName[category],
                    )));
  }

  Widget get _buildSeeAllTvShowsWidget {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double topPadding = padding.top + kToolbarHeight + 5;
    final double bottomPadding = padding.bottom + 30;

    return BlocBuilder<SeeAllTvShowsBloc, SeeAllTvShowsState>(
        cubit: _seeAllTvShowsBloc,
        builder: (context, state) {
          final tvShowsList = _seeAllTvShowsBloc.tvShowsList;
          final tvShows = tvShowsList.tvShows;

          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: isIOS
                  ? EdgeInsets.only(
                      top: topPadding, left: 10, bottom: bottomPadding)
                  : const EdgeInsets.only(top: 20, left: 10, bottom: 20),
              controller: _scrollControllerUtil.scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToTvShowDetails(tvShows[index].id,
                        tvShows[index].name, widget.tvShowCategory);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.none)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 85,
                            width: 63,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Image.network(
                                IMAGE_BASE_URL +
                                    PosterSizes.w92 +
                                    tvShows[index].posterPath,
                                fit: BoxFit.fill)),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  tvShows[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, left: 8),
                                child: Text(
                                  getTvShowsGenres(tvShows[index].genreIds),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 5),
                                child: buildRatingWidget(
                                    tvShows[index].voteAverage,
                                    tvShows[index].voteCount),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, right: 10),
                          child: Icon(
                            CupertinoIcons.forward,
                            color: Colors.grey,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20,
                  thickness: 0.2,
                  color: Colors.grey,
                );
              },
              itemCount: tvShows.length);
        });
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  tvShowsCategoryName[widget.tvShowCategory],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeeAllTvShowsWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text(tvShowsCategoryName[widget.tvShowCategory]),
            ),
            body: _buildSeeAllTvShowsWidget,
          );
  }
}
