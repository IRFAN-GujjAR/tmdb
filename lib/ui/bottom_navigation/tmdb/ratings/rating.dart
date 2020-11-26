import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/tmdb/rated/rated_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/rated/rated_events.dart';
import 'package:tmdb/bloc/home/tmdb/rated/rated_states.dart';
import 'package:tmdb/models/rated_model.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/tmdb/rated/rated_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/ratings/movies/rated_movies.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/ratings/tv_shows/rated_tv_shows.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

import '../../../../main.dart';

enum _Rating { Movies, TvShows }

class Rating extends StatefulWidget {
  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating>
    with SingleTickerProviderStateMixin<Rating> {
  RatedBloc _ratedBloc;

  TabController _tabController;
  _Rating _rating = _Rating.Movies;

  @override
  void initState() {
    _ratedBloc =
        RatedBloc(ratedRepo: RatedRepo(client: getHttpClient(context)));
    _initializeRatedBloc();
    super.initState();
  }

  @override
  void dispose() {
    _ratedBloc.close();
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

  void _initializeRatedBloc() async {
    _ratedBloc.add(LoadRated(
        user: Provider.of<LoginInfoProvider>(context, listen: false).user));
  }

  void _initializeTabController(RatedModel rated) {
    int length = 0;
    if (rated.isMovies) length++;
    if (rated.isTvShows) length++;
    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
  }

  List<Widget> _buildPages(RatedModel rated) {
    List<Widget> pages = [];

    if (rated.isMovies) {
      pages.add(RatedMovies(
        moviesList: rated.moviesList,
      ));
    }
    if (rated.isTvShows) {
      pages.add(RatedTvShows(
        tvShowsList: rated.tvShowsList,
      ));
    }

    return pages;
  }

  Widget _buildTabs(RatedModel rated) {
    Map<_Rating, Widget> tabBars = {};
    if (rated.isMovies && rated.isTvShows) {
      tabBars = {
        _Rating.Movies: Text(
          'Movies',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        _Rating.TvShows: Text(
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
        CupertinoSlidingSegmentedControl<_Rating>(
            children: tabBars,
            groupValue: _rating,
            onValueChanged: (value) {
              setState(() {
                switch (value) {
                  case _Rating.Movies:
                    _rating = _Rating.Movies;
                    _tabController.index = 0;
                    break;
                  case _Rating.TvShows:
                    _rating = _Rating.TvShows;
                    _tabController.index = 1;
                    break;
                }
              });
            })
      ]),
    );
  }

  Widget get _buildRatingWidget {
    final topPadding = MediaQuery.of(context).padding.top + kToolbarHeight - 12;

    return BlocConsumer<RatedBloc, RatedState>(
      cubit: _ratedBloc,
      listener: (context, state) {
        if (state is RatedLoaded) {
          _initializeTabController(state.rated);
        }
      },
      builder: (context, state) {
        if (state is RatedLoaded) {
          return Container(
            margin: EdgeInsets.only(top: isIOS ? topPadding : 0),
            child: Column(
              children: <Widget>[
                _buildTabs(state.rated),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: _buildPages(state.rated),
                  ),
                ),
              ],
            ),
          );
        } else if (state is RatedEmpty) {
          return Center(
            child: Text('You have not yet rated any movie or tv show!'),
          );
        } else if (state is RatedLoadingError) {
          return InternetConnectionErrorWidget(onPressed: _initializeRatedBloc);
        }
        return LoadingWidget();
      },
    );
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
                    'Rating',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            child: _buildRatingWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text('Rating'),
            ),
            body: _buildRatingWidget);
  }
}
