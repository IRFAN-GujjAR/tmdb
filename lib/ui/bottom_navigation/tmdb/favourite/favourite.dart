import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/tmdb/favourite/favourite_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/favourite/favourite_events.dart';
import 'package:tmdb/bloc/home/tmdb/favourite/favourite_states.dart';
import 'package:tmdb/models/favourite_model.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/tmdb/favourite/favourite_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/favourite/movies/favourite_movies.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/favourite/tv_shows/favourite_tv_shows.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';
import '../../../../main.dart';

enum _Favourites { Movies, TvShows }

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>
    with SingleTickerProviderStateMixin<Favourite> {
  FavouriteBloc _favouriteBloc;
  TabController _tabController;
  _Favourites _favourites = _Favourites.Movies;

  @override
  void initState() {
    _favouriteBloc = FavouriteBloc(
        favouriteRepo: FavouriteRepo(client: getHttpClient(context)));
    _initializeFavouriteBloc();
    super.initState();
  }

  @override
  void dispose() {
    _favouriteBloc.close();
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

  void _initializeFavouriteBloc() {
    _favouriteBloc.add(LoadFavourite(
        user: Provider.of<LoginInfoProvider>(context, listen: false).user));
  }

  void _initializeTabController(FavouriteModel favourites) {
    int length = 0;
    if (favourites.isMovies) {
      length++;
    }
    if (favourites.isTvShows) {
      length++;
    }
    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
  }

  List<Widget> _buildPages(FavouriteModel favourites) {
    List<Widget> pages = [];

    if (favourites.isMovies) {
      pages.add(FavouriteMovies(
        moviesList: favourites.moviesList,
      ));
    }
    if (favourites.isTvShows) {
      pages.add(FavouriteTvShows(
        tvShowsList: favourites.tvShowsList,
      ));
    }

    return pages;
  }

  Widget _buildTabs(FavouriteModel favourites) {
    Map<_Favourites, Widget> tabBars = {};

    if (favourites.isMovies && favourites.isTvShows) {
      tabBars = {
        _Favourites.Movies: Text(
          'Movies',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        _Favourites.TvShows: Text(
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
        CupertinoSlidingSegmentedControl<_Favourites>(
            children: tabBars,
            groupValue: _favourites,
            onValueChanged: (value) {
              setState(() {
                switch (value) {
                  case _Favourites.Movies:
                    _favourites = _Favourites.Movies;
                    _tabController.index = 0;
                    break;
                  case _Favourites.TvShows:
                    _favourites = _Favourites.TvShows;
                    _tabController.index = 1;
                    break;
                }
              });
            })
      ]),
    );
  }

  Widget get _buildFavouriteWidget {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight - 12;

    return BlocConsumer<FavouriteBloc, FavouriteState>(
        cubit: _favouriteBloc,
        listener: (context, state) {
          if (state is FavouriteLoaded) {
            _initializeTabController(state.favourites);
          }
        },
        builder: (context, state) {
          if (state is FavouriteLoaded) {
            return Container(
              margin: EdgeInsets.only(top: isIOS ? topPadding : 0),
              child: Column(
                children: <Widget>[
                  _buildTabs(state.favourites),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: _buildPages(state.favourites),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FavouriteEmpty) {
            return Center(
              child: Text('No Movie or Tv Show is added to favourite!'),
            );
          } else if (state is FavouriteLoadingError) {
            return InternetConnectionErrorWidget(
                onPressed: _initializeFavouriteBloc);
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
                    'Favourite',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            child: _buildFavouriteWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text('Favourite'),
            ),
            body: _buildFavouriteWidget);
  }
}
