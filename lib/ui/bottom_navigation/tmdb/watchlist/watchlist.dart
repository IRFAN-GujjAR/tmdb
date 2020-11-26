import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/tmdb/watch_list/watch_list_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/watch_list/watch_list_events.dart';
import 'package:tmdb/bloc/home/tmdb/watch_list/watch_list_states.dart';
import 'package:tmdb/models/watchlist_model.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/tmdb/watch_list/watch_list_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/watchlist/movies/watchlist_movies.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/watchlist/tv_shows/watchlist_tv_shows.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

import '../../../../main.dart';

enum _WatchList { Movies, TvShows }

class WatchList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<WatchList>
    with SingleTickerProviderStateMixin<WatchList> {
  WatchListBloc _watchListBloc;

  TabController _tabController;
  _WatchList _watchList = _WatchList.Movies;

  @override
  void initState() {
    _watchListBloc = WatchListBloc(
        watchListRepo: WatchListRepo(client: getHttpClient(context)));
    _initializeWatchListBloc();
    super.initState();
  }

  @override
  void dispose() {
    _watchListBloc.close();
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _initializeWatchListBloc() async {
    _watchListBloc.add(LoadWatchList(
        user: Provider.of<LoginInfoProvider>(context, listen: false).user));
  }

  void _initializeTabController(WatchListModel watchList) {
    int length = 0;
    if (watchList.isMovies) length++;
    if (watchList.isTvShows) length++;
    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
  }

  List<Widget> _buildPages(WatchListModel watchList) {
    List<Widget> pages = [];

    if (watchList.isMovies) {
      pages.add(WatchListMovies(
        moviesList: watchList.moviesList,
      ));
    }
    if (watchList.isTvShows) {
      pages.add(WatchListTvShows(
        tvShowsList: watchList.tvShowsList,
      ));
    }

    return pages;
  }

  Widget _buildTabs(WatchListModel watchList) {
    Map<_WatchList, Widget> tabBars = {};
    if (watchList.isMovies && watchList.isTvShows) {
      tabBars = {
        _WatchList.Movies: Text(
          'Movies',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        _WatchList.TvShows: Text(
          'Tv Shows',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      };
    }

    if (tabBars.isEmpty) {
      return Container();
    }

    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Colors.grey[900]
          : Colors.grey[900],
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CupertinoSlidingSegmentedControl<_WatchList>(
            children: tabBars,
            groupValue: _watchList,
            onValueChanged: (value) {
              setState(() {
                switch (value) {
                  case _WatchList.Movies:
                    _watchList = _WatchList.Movies;
                    _tabController.index = 0;
                    break;
                  case _WatchList.TvShows:
                    _watchList = _WatchList.TvShows;
                    _tabController.index = 1;
                    break;
                }
              });
            })
      ]),
    );
  }

  Widget get _buildWatchListWidget {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight - 12;

    return BlocConsumer<WatchListBloc, WatchListState>(
        cubit: _watchListBloc,
        listener: (context, state) {
          if (state is WatchListLoaded) {
            _initializeTabController(state.watchList);
          }
        },
        builder: (context, state) {
          if (state is WatchListLoaded) {
            return Container(
              margin: EdgeInsets.only(top: isIOS?topPadding:0),
              child: Column(
                children: <Widget>[
                  _buildTabs(state.watchList),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: _buildPages(state.watchList),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WatchListEmpty) {
            return Center(
              child: Text('No Movie or Tv Show is added to watchlist!'),
            );
          } else if (state is WatchListLoadingError) {
            return InternetConnectionErrorWidget(
                onPressed: _initializeWatchListBloc);
          }
          return LoadingWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                previousPageTitle:
                    Provider.of<LoginInfoProvider>(context).username,
                middle: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    'WatchList',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            child: _buildWatchListWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text('WatchList'),
            ),
            body: _buildWatchListWidget);
  }
}
