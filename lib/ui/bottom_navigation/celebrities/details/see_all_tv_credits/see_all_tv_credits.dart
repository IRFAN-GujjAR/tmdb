import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/celebrities_details_data.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/utils/utils.dart';

enum _TvCredits { Cast, Crew }

class SeeAllTvCredits extends StatefulWidget {
  final String previousPageTitle;
  final TvCredits tvCredits;

  SeeAllTvCredits({this.previousPageTitle, this.tvCredits});

  @override
  _SeeAllTvCreditsState createState() => _SeeAllTvCreditsState();
}

class _SeeAllTvCreditsState extends State<SeeAllTvCredits>
    with SingleTickerProviderStateMixin<SeeAllTvCredits> {
  TabController _tabController;

  _TvCredits _credits = _TvCredits.Cast;

  @override
  void initState() {
    super.initState();

    int length = 0;

    if ((widget.tvCredits.cast != null && widget.tvCredits.cast.isNotEmpty) &&
        (widget.tvCredits.crew != null && widget.tvCredits.crew.isNotEmpty)) {
      length = 2;
    } else {
      length = 1;
    }

    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
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
    _tabController.dispose();
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (widget.tvCredits.cast != null && widget.tvCredits.cast.isNotEmpty) {
      pages.add(AllTvShows(
        tvShows: widget.tvCredits.cast,
      ));
    }
    if (widget.tvCredits.crew != null && widget.tvCredits.crew.isNotEmpty) {
      pages.add(AllTvShows(
        tvShows: widget.tvCredits.crew,
      ));
    }

    return pages;
  }

  Widget _buildTabTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  Widget get _buildTabs {
    Map<_TvCredits, Widget> tabBars = {};

    if (widget.tvCredits.cast != null && widget.tvCredits.cast.isNotEmpty) {
      tabBars.addAll({_TvCredits.Cast: _buildTabTitle('Cast')});
    }
    if (widget.tvCredits.crew != null && widget.tvCredits.crew.isNotEmpty) {
      tabBars.addAll({_TvCredits.Crew: _buildTabTitle('Crew')});
    }
    if (tabBars.length < 2) {
      return Container();
    }

    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CupertinoSlidingSegmentedControl<_TvCredits>(
            groupValue: _credits,
            children: tabBars,
            onValueChanged: (value) {
              setState(() {
                switch (value) {
                  case _TvCredits.Cast:
                    _credits = _TvCredits.Cast;
                    _tabController.index = 0;
                    break;
                  case _TvCredits.Crew:
                    _credits = _TvCredits.Crew;
                    _tabController.index = 1;
                    break;
                }
              });
            })
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top + kToolbarHeight - 12;

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  'TvShows',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: _buildTabs,
                ),
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
        : Scaffold(
            appBar: AppBar(
              title: Text('Tv Shows'),
            ),
            body: Column(
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
          );
  }
}

class AllTvShows extends StatefulWidget {
  final List<TvShowsData> tvShows;

  AllTvShows({@required this.tvShows});

  @override
  _AllTvShowsState createState() => _AllTvShowsState();
}

class _AllTvShowsState extends State<AllTvShows>
    with AutomaticKeepAliveClientMixin<AllTvShows> {
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w92';

  void _navigateToMovieDetails(int id, String movieTitle) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: 'Back',
                    )));
  }

  Widget _buildRatingWidget(double voteAverage, int voteCount) {
    List<IconData> stars;

    double rating = voteAverage / 2;
    int counter = rating.toInt();

    for (int i = 0; i < counter; i++) {
      stars == null ? stars = [Icons.star] : stars.add(Icons.star);
    }

    if (rating.toString().contains('.')) {
      if (voteCount == 0 && voteAverage == 0) {
        stars = [Icons.star_border];
      } else {
        stars == null ? stars = [Icons.star_half] : stars.add(Icons.star_half);
      }
    }
    while (stars.length < 5) {
      stars.add(Icons.star_border);
    }

    return Container(
      margin: const EdgeInsets.only(top: 2, left: 4),
      height: 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return index != 5
              ? Icon(
                  stars[index],
                  size: 15,
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 5, top: 2),
                  child: Text(
                    '( $voteCount )',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ));
        },
        itemCount: 6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: isIOS
            ? EdgeInsets.only(left: 10, top: 20, bottom: bottomPadding)
            : const EdgeInsets.only(left: 10, top: 20, bottom: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToMovieDetails(
                  widget.tvShows[index].id, widget.tvShows[index].name);
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
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Image.network(
                          _imageBaseUrl + widget.tvShows[index].posterPath,
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
                            widget.tvShows[index].name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8),
                          child: Text(
                            getTvShowsGenres(widget.tvShows[index].genreIds),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 5),
                          child: _buildRatingWidget(
                              widget.tvShows[index].voteAverage,
                              widget.tvShows[index].voteCount),
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
        itemCount: widget.tvShows.length);
  }

  @override
  bool get wantKeepAlive => true;
}
