import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/tmdb/watchlist/movies/watchlist_movies.dart';
import 'package:tmdb/bottom_navigation/tmdb/watchlist/tv_shows/watchlist_tv_shows.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/tmdb_account/tmdb_account_api.dart';
import 'package:http/http.dart' as http;
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as customTabBar;

import '../../../main.dart';

class WatchList extends StatefulWidget {
  final String username;
  final String sessionId;
  final String accountId;

  WatchList(
      {@required this.username,
      @required this.sessionId,
      @required this.accountId});

  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList>
    with SingleTickerProviderStateMixin<WatchList> {
  MoviesList _moviesList;
  TvShowsList _tvShowsList;
  bool _isMovies = false;
  bool _isTvShows = false;
  bool _isLoading = true;
  bool _resultsNotFound = false;

  int cupertinoTabBarValue = 0;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  TabController _tabController;

  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeWatchList();
      }
    });
    _initializeWatchList();
  }

  @override
  void dispose() {
    super.dispose();
    if (_tabController != null) {
      _tabController.dispose();
    }
    _subscription.cancel();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _initializeWatchList() async {
    setState(() {
      _isLoading = true;
    });

    int length = 0;
    _moviesList = await getWatchListMovies(
        http.Client(), widget.sessionId, widget.accountId, 1);
    _tvShowsList = await getWatchListTvShows(
        http.Client(), widget.sessionId, widget.accountId, 1);

    if (_moviesList == null || _tvShowsList == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      if (_moviesList.movies.isEmpty && _tvShowsList.tvShows.isEmpty) {
        setState(() {
          _resultsNotFound = true;
        });
      } else {
        if (_moviesList.movies.isNotEmpty && _tvShowsList.tvShows.isNotEmpty) {
          _isMovies = true;
          _isTvShows = true;
          length = 2;
        } else {
          if (_moviesList.movies.isNotEmpty) {
            length++;
            _isMovies = true;
          }
          if (_tvShowsList.tvShows.isNotEmpty) {
            length++;
            _isTvShows = true;
          }
        }


      }
      setState(() {
        _isInternet = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (_isMovies) {
      pages.add(WatchListMovies(
        moviesList: _moviesList,
        sessionId: widget.sessionId,
        accountId: widget.accountId,
      ));
    }
    if (_isTvShows) {
      pages.add(WatchListTvShows(
        tvShowsList: _tvShowsList,
        sessionId: widget.sessionId,
        accountId: widget.accountId,
      ));
    }

    return pages;
  }

  Widget get _buildTabs {
    List<Widget> titles = [];

    if (_isMovies && _isTvShows) {
      titles.add(Center(
        child: Text(
          'Movies',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ));
      titles.add(Center(
        child: Text(
          'Tv Shows',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ));
    }

    if (titles.isEmpty) {
      return Container();
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

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top + kToolbarHeight - 12;

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                previousPageTitle: widget.username,
                middle: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    'WatchList',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            child: _isLoading
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : _isInternet
                    ? _resultsNotFound
                        ? Center(
                            child: Text(
                                'No Movie or Tv Show is added to watchlist!'),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: topPadding),
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
                        onPressed: _initializeWatchList,
                      ))
        : Scaffold(
            appBar: AppBar(
              title: Text('WatchList'),
            ),
            body: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _isInternet
                    ? _resultsNotFound
                        ? Center(
                            child: Text(
                                'No Movie or Tv Show is added to watchlist!'),
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
                        onPressed: _initializeWatchList,
                      ),
          );
  }
}
