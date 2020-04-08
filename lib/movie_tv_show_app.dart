import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/provider/movie_provider.dart';

import 'bottom_navigation/celebrities/celebrities.dart';
import 'bottom_navigation/movies/movies.dart';
import 'bottom_navigation/search/search.dart';
import 'bottom_navigation/tmdb/tmdb.dart';
import 'bottom_navigation/tv_shows/tv_shows.dart';
import 'main.dart';

enum TabItem { movies, tvShows, celebs, search, account }

Map<TabItem, String> tabName = {
  TabItem.movies: 'Movies',
  TabItem.tvShows: 'Tv Shows',
  TabItem.celebs: 'Celebrities',
  TabItem.search: 'Search',
  TabItem.account: 'TMDB'
};

class MovieTvShowApp extends StatefulWidget {
  @override
  _MovieTvShowAppState createState() => _MovieTvShowAppState();
}

class _MovieTvShowAppState extends State<MovieTvShowApp> {
  List<GlobalKey<NavigatorState>> _navigationKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [Movies(), TvShows(), Celebrities(), Search(), TMDb()];
  }

  int _index = 0;

  List<int> _indexesStack = [0];

  final List<BottomNavigationBarItem> _bottomNavigationItems = [
    BottomNavigationBarItem(
        title: Text(tabName[TabItem.movies]), icon: Icon(Icons.local_movies)),
    BottomNavigationBarItem(
        title: Text(tabName[TabItem.tvShows]), icon: Icon(Icons.tv)),
    BottomNavigationBarItem(
        title: Text(tabName[TabItem.celebs]), icon: Icon(Icons.person)),
    BottomNavigationBarItem(
        title: Text(tabName[TabItem.search]), icon: Icon(Icons.search)),
    BottomNavigationBarItem(
        title: Text(tabName[TabItem.account]), icon: Icon(Icons.account_box))
  ];

  void _selectTab(int index) {
    if (_navigationKeys[index].currentState != null && _index == index) {
      _navigationKeys[_index].currentState.popUntil((route) => route.isFirst);
    }
    setState(() {
      _index = index;
    });
  }

  Widget _buildOffStageNavigator(int index) {
    return Offstage(
      offstage: _index != index,
      child: Navigator(
        key: _navigationKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) {
            return pages[index];
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieTvShowProvider>(
      create: (context) => MovieTvShowProvider(),
      child: isIOS
          ? CupertinoTabScaffold(
              resizeToAvoidBottomInset: false,
              tabBar: CupertinoTabBar(
                onTap: (index) {
                  if (_navigationKeys[index].currentState != null &&
                      _index == index) {
                    _navigationKeys[index]
                        .currentState
                        .popUntil((state) => state.isFirst);
                  }
                  _index = index;
                },
                items: _bottomNavigationItems,
              ),
              tabBuilder: (BuildContext context, int index) {
                return CupertinoTabView(
                  navigatorKey: _navigationKeys[index],
                  builder: (context) => pages[index],
                );
              },
            )
          : WillPopScope(
              onWillPop: () async {
                final isFirstRouteInCurrentTab =
                    !await _navigationKeys[_index].currentState.maybePop();
                if (isFirstRouteInCurrentTab) {
                  {
                    if (_index != 0) {
                      _indexesStack.removeLast();
                      _selectTab(_indexesStack.last);
                      return false;
                    }
                  }
                }
                return isFirstRouteInCurrentTab;
              },
              child: Scaffold(
                body: Stack(
                  children: <Widget>[
                    _buildOffStageNavigator(0),
                    _buildOffStageNavigator(1),
                    _buildOffStageNavigator(2),
                    _buildOffStageNavigator(3),
                    _buildOffStageNavigator(4),
                  ],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.black,
                  items: _bottomNavigationItems,
                  currentIndex: _index,
                  selectedItemColor: Colors.blue,
                  showUnselectedLabels: true,
                  selectedFontSize: 12,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    setState(() {
                      if (_index != index) {
                        _indexesStack.add(index);
                      }
                      _selectTab(index);
                    });
                  },
                ),
              ),
            ),
    );
  }
}
