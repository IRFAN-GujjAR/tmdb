import 'dart:async';
import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/tv_shows/see_all/see_all_tv_shows.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/utils/utils.dart';

import '../../main.dart';
import '../../movie_tv_show_app.dart';
import 'details/tv_shows_details.dart';

Map<TvShowsCategories, String> tvShowsCategoryName = {
  TvShowsCategories.AiringToday: 'Airing Today',
  TvShowsCategories.Trending: 'Trending',
  TvShowsCategories.TopRated: 'Top Rated',
  TvShowsCategories.Popular: 'Popular',
  TvShowsCategories.DetailsRecommended: 'Recommended',
  TvShowsCategories.DetailsSimilar: 'Similar'
};

class TvShows extends StatefulWidget {

  TvShows({Key key}) : super(key: key);

  _TvShowsState createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  List<TvShowsList> _tvShowsLists = [];
  bool _isDataLoaded = false;
  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeTvShows();
      }
    });
    _initializeTvShows();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _initializeTvShows() async {
    setState(() {
      _isDataLoaded = false;
    });
    _tvShowsLists = await fetchTvShows(http.Client());
    if (_tvShowsLists != null) {
      setState(() {
        _isInternet = true;
      });
    } else {
      setState(() {
        _isInternet = false;
      });
    }
    setState(() {
      _isDataLoaded = true;
    });
  }

  void _navigateToSeeAllTvShows(
      TvShowsCategories tvShowsCategory, TvShowsList tvShowsList) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return SeeAllTvShows(
                  previousPageTitle: 'Tv Shows',
                  tvShowCategory: tvShowsCategory,
                  tvShowsList: tvShowsList,
                  tvShowId: null,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return SeeAllTvShows(
                  previousPageTitle: 'Tv Shows',
                  tvShowCategory: tvShowsCategory,
                  tvShowsList: tvShowsList,
                  tvShowId: null,
                );
              }));
  }

  Widget _buildTextRow(
      TvShowsCategories tvShowsCategory, TvShowsList tvShowsList) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            tvShowsCategoryName[tvShowsCategory],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllTvShows(tvShowsCategory, tvShowsList);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Icon(CupertinoIcons.forward, color: Colors.grey, size: 14)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _divider(TvShowsCategories tvShowsCategory) {
    return Container(
      margin: _getDividerMargin(tvShowsCategory),
      height: 0.8,
      color: Colors.grey[900],
    );
  }

  EdgeInsets _getDividerMargin(TvShowsCategories tvShowsCategory) {
    if (tvShowsCategory == TvShowsCategories.AiringToday) {
      return const EdgeInsets.only(left: 12, top: 12.0);
    } else if (tvShowsCategory == TvShowsCategories.Trending) {
      return const EdgeInsets.only(left: 12, top: 10.0);
    } else if (tvShowsCategory == TvShowsCategories.TopRated) {
      return const EdgeInsets.only(left: 12, top: 12.0);
    } else {
      return const EdgeInsets.only(left: 12, top: 20.0);
    }
  }

  void _navigateToTvShowDetails(BuildContext context, TvShowsData tvShow) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: tvShow.id,
                      tvShowTitle: tvShow.name,
                      previousPageTitle: 'Tv Shows',
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: tvShow.id,
                      tvShowTitle: tvShow.name,
                      previousPageTitle: 'Tv Shows',
                    )));
  }

  Widget _buildCategoryWidgets(
      TvShowsCategories tvShowsCategory, List<TvShowsData> tvShows) {
    _TvShowsItemConfiguration tvShowsItemConfiguration =
        _TvShowsItemConfiguration(tvShowsCategory: tvShowsCategory);

    int font = 12;
    if (tvShowsCategory == TvShowsCategories.AiringToday) {
      font = 15;
    } else {
      font = 12;
    }

    return Container(
      height: tvShowsItemConfiguration.listViewHeight,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tvShows.length < 20 ? tvShows.length : 20,
        padding: const EdgeInsets.only(left: 12, right: 12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: 20,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _navigateToTvShowDetails(context, tvShows[index]);
            },
            child: Container(
              width: tvShowsItemConfiguration.listItemWidth,
              child: Column(
                children: <Widget>[
                  Container(
                      height: tvShowsItemConfiguration.imageHeight,
                      width: tvShowsItemConfiguration.listItemWidth,
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.grey),
                      ),
                      child: tvShowsCategory == TvShowsCategories.AiringToday
                          ? Image.network(
                              tvShowsItemConfiguration.imageUrl +
                                  tvShows[index].backdropPath,
                              fit: BoxFit.fill)
                          : Image.network(
                              tvShowsItemConfiguration.imageUrl +
                                  tvShows[index].posterPath,
                              fit: BoxFit.fill)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(
                          tvShows[index].name,
                          maxLines: tvShowsCategory ==
                                      TvShowsCategories.AiringToday ||
                                  tvShowsCategory == TvShowsCategories.TopRated
                              ? 1
                              : 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: font.toDouble()),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(
                          getTvShowsGenres(tvShows[index].genreIds),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: tvShowsCategory ==
                                      TvShowsCategories.AiringToday
                                  ? 12
                                  : 11),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopRatedItems(TvShowsData tvShow) {
    return GestureDetector(
      onTap: () {
        _navigateToTvShowDetails(context, tvShow);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(width: 0, style: BorderStyle.none)),
        child: Row(
          children: <Widget>[
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w92' + tvShow.posterPath,
                  fit: BoxFit.fitWidth,
                )),
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
                    getTvShowsGenres(tvShow.genreIds),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Spacer(),
            Icon(
              CupertinoIcons.forward,
              color: Colors.grey,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopRatedTvShows(List<TvShowsData> tvShows) {
    List<TvShowsData> firstPairTvShows;
    List<TvShowsData> secondPairTvShows;
    List<TvShowsData> thirdPairTvShows;

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

    return Container(
      height: 200,
      child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int mainIndex) {
            return Container(
              margin: const EdgeInsets.only(left: 12),
              width: 310,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTopRatedItems(mainIndex, 0, firstPairTvShows,
                      secondPairTvShows, thirdPairTvShows),
                  _getTopRatedItems(mainIndex, 1, firstPairTvShows,
                      secondPairTvShows, thirdPairTvShows),
                  _getTopRatedItems(mainIndex, 2, firstPairTvShows,
                      secondPairTvShows, thirdPairTvShows),
                  _getTopRatedItems(mainIndex, 3, firstPairTvShows,
                      secondPairTvShows, thirdPairTvShows),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              width: 8,
            );
          },
          itemCount: 3),
    );
  }

  Widget _getTopRatedItems(
    int mainIndex,
    int itemIndex,
    List<TvShowsData> firstPairMovies,
    List<TvShowsData> secondPairMovies,
    List<TvShowsData> thirdPairMovies,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTopRatedItems(firstPairMovies[itemIndex]);
      case 1:
        return _buildTopRatedItems(secondPairMovies[itemIndex]);
      case 2:
        return _buildTopRatedItems(thirdPairMovies[itemIndex]);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double bottomPadding = padding.bottom + 20;

    return isIOS
        ? CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text(tabName[TabItem.tvShows]),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _isDataLoaded
                      ? _isInternet
                          ? SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: bottomPadding, top: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _buildTextRow(TvShowsCategories.AiringToday,
                                        _tvShowsLists[0]),
                                    _buildCategoryWidgets(
                                        TvShowsCategories.AiringToday,
                                        _tvShowsLists[0].tvShows),
                                    _divider(TvShowsCategories.AiringToday),
                                    _buildTextRow(TvShowsCategories.Trending,
                                        _tvShowsLists[1]),
                                    _buildCategoryWidgets(
                                        TvShowsCategories.Trending,
                                        _tvShowsLists[1].tvShows),
                                    _divider(TvShowsCategories.Trending),
                                    _buildTextRow(TvShowsCategories.TopRated,
                                        _tvShowsLists[2]),
                                    _buildTopRatedTvShows(
                                        _tvShowsLists[2].tvShows),
                                    _divider(TvShowsCategories.TopRated),
                                    _buildTextRow(TvShowsCategories.Popular,
                                        _tvShowsLists[3]),
                                    _buildCategoryWidgets(
                                        TvShowsCategories.Popular,
                                        _tvShowsLists[3].tvShows),
                                  ],
                                ),
                              ),
                            )
                          : InternetConnectionErrorWidget(
                              onPressed: _initializeTvShows,
                            )
                      : Center(
                          child: CupertinoActivityIndicator(),
                        ),
                )
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(tabName[TabItem.tvShows]),
            ),
            body: _isDataLoaded
                ? _isInternet
                    ? SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildTextRow(TvShowsCategories.AiringToday,
                                  _tvShowsLists[0]),
                              _buildCategoryWidgets(
                                  TvShowsCategories.AiringToday,
                                  _tvShowsLists[0].tvShows),
                              _divider(TvShowsCategories.AiringToday),
                              _buildTextRow(
                                  TvShowsCategories.Trending, _tvShowsLists[1]),
                              _buildCategoryWidgets(TvShowsCategories.Trending,
                                  _tvShowsLists[1].tvShows),
                              _divider(TvShowsCategories.Trending),
                              _buildTextRow(
                                  TvShowsCategories.TopRated, _tvShowsLists[2]),
                              _buildTopRatedTvShows(_tvShowsLists[2].tvShows),
                              _divider(TvShowsCategories.TopRated),
                              _buildTextRow(
                                  TvShowsCategories.Popular, _tvShowsLists[3]),
                              _buildCategoryWidgets(TvShowsCategories.Popular,
                                  _tvShowsLists[3].tvShows),
                            ],
                          ),
                        ),
                      )
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeTvShows,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
  }
}

class _TvShowsItemConfiguration {
  final TvShowsCategories tvShowsCategory;
  double listViewHeight;
  double imageHeight;
  double listItemWidth;
  String imageUrl = IMAGE_BASE_URL;

  _TvShowsItemConfiguration({@required this.tvShowsCategory})
      : assert(tvShowsCategory != null) {
    _initializeAllValues(tvShowsCategory);
  }

  _initializeAllValues(TvShowsCategories tvShowsCategory) {
    if (tvShowsCategory == TvShowsCategories.AiringToday) {
      listViewHeight = 170;
      imageHeight = 122;
      listItemWidth = 209;
      imageUrl += BackDropSizes.w300;
    } else if (tvShowsCategory == TvShowsCategories.Trending) {
      listViewHeight = 200;
      imageHeight = 139;
      listItemWidth = 99;
      imageUrl += PosterSizes.w185;
    } else if (tvShowsCategory == TvShowsCategories.TopRated) {
      listViewHeight = 240;
      imageHeight = 180;
      listItemWidth = 120;
      imageUrl += PosterSizes.w92;
    } else if (tvShowsCategory == TvShowsCategories.Popular) {
      listViewHeight = 220;
      imageHeight = 150;
      listItemWidth = 107;
      imageUrl += PosterSizes.w185;
    }
  }
}
