import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/provider/bottom_navigation_provider.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/celebrities.dart';
import 'package:tmdb/ui/bottom_navigation/movies/movies.dart';
import 'package:tmdb/ui/bottom_navigation/search/search.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/tmdb.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/tv_shows.dart';

enum TabItem { movies, tvShows, celebs, search, account }

Map<TabItem, String> tabName = {
  TabItem.movies: 'Movies',
  TabItem.tvShows: 'Tv Shows',
  TabItem.celebs: 'Celebrities',
  TabItem.search: 'Search',
  TabItem.account: 'TMDB'
};

class MovieTvShowApp extends StatelessWidget {
  final _pages = [Movies(), TvShows(), Celebrities(), Search(), TMDb()];

  final List<BottomNavigationBarItem> _bottomNavigationItems = [
    BottomNavigationBarItem(
        label: tabName[TabItem.movies], icon: Icon(Icons.local_movies)),
    BottomNavigationBarItem(
        label: tabName[TabItem.tvShows], icon: Icon(Icons.tv)),
    BottomNavigationBarItem(
        label: tabName[TabItem.celebs], icon: Icon(Icons.person)),
    BottomNavigationBarItem(
        label: tabName[TabItem.search], icon: Icon(Icons.search)),
    BottomNavigationBarItem(
        label: tabName[TabItem.account], icon: Icon(Icons.account_box))
  ];

  Widget _buildOffStageNavigator(
      BottomNavigationProvider bottomNavProvider, int index) {
    return Offstage(
      offstage: bottomNavProvider.index != index,
      child: Navigator(
        key: bottomNavProvider.navigationKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(builder: (context) {
            return _pages[index];
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavigationProvider>(context);
    return isIOS
        ? CupertinoTabScaffold(
            resizeToAvoidBottomInset: false,
            tabBar: CupertinoTabBar(
              onTap: (index) {
                bottomNavProvider.selectTab(index);
              },
              items: _bottomNavigationItems,
            ),
            tabBuilder: (BuildContext context, int index) {
              return CupertinoTabView(
                navigatorKey: bottomNavProvider.navigationKeys[index],
                builder: (context) => _pages[index],
              );
            },
          )
        : WillPopScope(
            onWillPop: () async {
              final isFirstRouteInCurrentTab =
                  await bottomNavProvider.onPopBack();
              return isFirstRouteInCurrentTab;
            },
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  _buildOffStageNavigator(bottomNavProvider, 0),
                  _buildOffStageNavigator(bottomNavProvider, 1),
                  _buildOffStageNavigator(bottomNavProvider, 2),
                  _buildOffStageNavigator(bottomNavProvider, 3),
                  _buildOffStageNavigator(bottomNavProvider, 4),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.black,
                items: _bottomNavigationItems,
                currentIndex: bottomNavProvider.index,
                selectedItemColor: Colors.blue,
                showUnselectedLabels: true,
                selectedFontSize: 12,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  bottomNavProvider.selectTab(index);
                },
              ),
            ),
          );
  }
}
