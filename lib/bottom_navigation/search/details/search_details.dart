import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/search/details/all/all_search.dart';
import 'package:tmdb/bottom_navigation/search/details/celebs/celebs_search.dart';
import 'package:tmdb/bottom_navigation/search/details/movies/movies_search.dart';
import 'package:tmdb/bottom_navigation/search/details/tv_shows/tv_shows_search.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/movie_tv_show_app.dart';
import 'package:tmdb/network/search_api.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as customTabBar;
import 'package:http/http.dart' as http;

enum _SearchCategories { All, Movies, TvShows, Celebs }

class SearchDetails extends StatefulWidget {
  final String typedText;

  SearchDetails(
      {
      @required this.typedText,});

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails>
    with SingleTickerProviderStateMixin<SearchDetails> {
  Map<_SearchCategories, String> _categoryName = {
    _SearchCategories.All: 'All',
    _SearchCategories.Movies: 'Movies',
    _SearchCategories.TvShows: 'Tv Shows',
    _SearchCategories.Celebs: 'Celebs'
  };

  int cupertinoTabBarValue = 0;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  MoviesList _moviesList;
  TvShowsList _tvShowsList;
  CelebritiesList _celebritiesList;

  bool _isAll = false;
  bool _isMovies = false;
  bool _isTvShows = false;
  bool _isCelebs = false;
  bool _resultsNotFound = false;
  bool _dataLoaded = false;
  bool _isInternet = true;

  TabController _tabController;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeSearch();
      }
    });
    _initializeSearch();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    if (_tabController != null) {
      _tabController.dispose();
    }
  }

  void _initializeSearch() async {
    setState(() {
      _dataLoaded = false;
      _resultsNotFound = false;
    });
      _moviesList =
          await searchMovies(http.Client(), widget.typedText, 1);
      _tvShowsList = await searchTvShows(
          http.Client(), widget.typedText, 1);
      _celebritiesList = await searchCelebrities(
          http.Client(), widget.typedText, 1);

    if (_moviesList == null ||
        _tvShowsList == null ||
        _celebritiesList == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      setState(() {
        _isInternet = true;
      });

      int length = 0;

      if (_moviesList.movies.isNotEmpty) {
        _isMovies = true;
        length++;
      }
      if (_tvShowsList.tvShows.isNotEmpty) {
        _isTvShows = true;
        length++;
      }
      if (_celebritiesList.celebrities.isNotEmpty) {
        _isCelebs = true;
        length++;
      }
      if (_isMovies && _isTvShows && _isCelebs) {
        length++;
        setState(() {
          _isAll = true;
        });
      }
      if (!_isMovies && !_isTvShows && !_isCelebs) {
        setState(() {
          _resultsNotFound = true;
        });
      }
      _tabController =
          TabController(initialIndex: 0, length: length, vsync: this);
    }
    setState(() {
      _dataLoaded = true;
    });
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];
    if (_isAll) {
      pages = [
        AllSearch(
          onClickSeeAll: (tabItem) {
            if (tabItem == TabItem.movies) {
              setState(() {
                cupertinoTabBarValue = 1;
                _tabController.index = 1;
              });
            } else if (tabItem == TabItem.tvShows) {
              setState(() {
                cupertinoTabBarValue = 2;
                _tabController.index = 2;
              });
            } else if (tabItem == TabItem.celebs) {
              setState(() {
                cupertinoTabBarValue = 3;
                _tabController.index = 3;
              });
            }
          },
          moviesList: _moviesList,
          tvShowsList: _tvShowsList,
          celebritiesList: _celebritiesList,
        ),
        MoviesSearch(
          searchQuery: widget.typedText,
          moviesList: _moviesList,
        ),
        TvShowsSearch(
          searchQuery: widget.typedText,
          tvShowsList: _tvShowsList,
        ),
        CelebritiesSearch(
          searchQuery: widget.typedText,
          celebritiesList: _celebritiesList,
        ),
      ];

      return pages;
    } else {
      if (_isMovies) {
        pages.add(MoviesSearch(
          searchQuery: widget.typedText,
          moviesList: _moviesList,
        ));
      }
      if (_isTvShows) {
        pages.add(TvShowsSearch(
          searchQuery: widget.typedText,
          tvShowsList: _tvShowsList,
        ));
      }
      if (_isCelebs) {
        pages.add(CelebritiesSearch(
          searchQuery: widget.typedText,
          celebritiesList: _celebritiesList,
        ));
      }
    }

    return pages;
  }

  Widget get _buildTabs {
    List<Widget> titles = [];
    if (_isAll) {
      titles = [
        _buildTabTitle(_SearchCategories.All),
        _buildTabTitle(_SearchCategories.Movies),
        _buildTabTitle(_SearchCategories.TvShows),
        _buildTabTitle(_SearchCategories.Celebs),
      ];
    } else {
      if (_isMovies) {
        titles.add(_buildTabTitle(_SearchCategories.Movies));
      }
      if (_isTvShows) {
        titles.add(_buildTabTitle(_SearchCategories.TvShows));
      }
      if (_isCelebs) {
        titles.add(_buildTabTitle(_SearchCategories.Celebs));
      }
      if (titles.length < 2) {
        return Container();
      }
    }

    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[900],
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        customTabBar.CupertinoTabBar(
          CupertinoColors.darkBackgroundGray,
          CupertinoColors.inactiveGray,
          titles,
          cupertinoTabBarValueGetter,
          (int index) {
            setState(() {
              cupertinoTabBarValue = index;
              _tabController.index = index;
            });
          },
          useSeparators: true,
          horizontalPadding: 4,
          verticalPadding: 8,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          duration: const Duration(milliseconds: 250),
        )
      ]),
    );
  }

  Widget _buildTabTitle(_SearchCategories searchCategory) {
    return Center(
      child: Text(
        _categoryName[searchCategory],
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _dataLoaded
        ? _isInternet
            ? _resultsNotFound
                ? Center(
                    child: Text('No results found!'),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        _buildTabs,
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            controller: _tabController,
                            children: _buildPages,
                          ),
                        ),
                      ],
                    ),
                  )
            : InternetConnectionErrorWidget(
                onPressed: _initializeSearch,
              )
        : Center(
            child: isIOS
                ? CupertinoActivityIndicator()
                : CircularProgressIndicator(),
          );
  }
}
