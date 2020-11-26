import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/celebrities_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/utils/utils.dart';

enum _MovieCredits { Cast, Crew }

class SeeAllMovieCredits extends StatefulWidget {
  final String previousPageTitle;
  final MovieCredits movieCredits;

  SeeAllMovieCredits(
      {@required this.previousPageTitle, @required this.movieCredits});

  @override
  _SeeAllMovieCreditsState createState() => _SeeAllMovieCreditsState();
}

class _SeeAllMovieCreditsState extends State<SeeAllMovieCredits>
    with SingleTickerProviderStateMixin<SeeAllMovieCredits> {
  TabController _tabController;

  _MovieCredits _movieCredits = _MovieCredits.Cast;

  @override
  void initState() {
    super.initState();

    int length = 0;

    if ((widget.movieCredits.cast != null &&
            widget.movieCredits.cast.isNotEmpty) &&
        (widget.movieCredits.crew != null &&
            widget.movieCredits.crew.isNotEmpty)) {
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

    if (widget.movieCredits.cast != null &&
        widget.movieCredits.cast.isNotEmpty) {
      pages.add(AllMovies(
        movies: widget.movieCredits.cast,
      ));
    }
    if (widget.movieCredits.crew != null &&
        widget.movieCredits.crew.isNotEmpty) {
      pages.add(AllMovies(
        movies: widget.movieCredits.crew,
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
    Map<_MovieCredits, Widget> tabBars = {};
    if (widget.movieCredits.cast != null &&
        widget.movieCredits.cast.isNotEmpty) {
      tabBars.addAll({_MovieCredits.Cast: _buildTabTitle('Cast')});
    }
    if (widget.movieCredits.crew != null &&
        widget.movieCredits.crew.isNotEmpty) {
      tabBars.addAll({_MovieCredits.Crew: _buildTabTitle('Crew')});
    }

    if (tabBars.length < 2) {
      return Container();
    }

    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CupertinoSlidingSegmentedControl<_MovieCredits>(
            groupValue: _movieCredits,
            children: tabBars,
            onValueChanged: (value) {
              setState(() {
                switch (value) {
                  case _MovieCredits.Cast:
                    _movieCredits = _MovieCredits.Cast;
                    _tabController.index = 0;
                    break;
                  case _MovieCredits.Crew:
                    _movieCredits = _MovieCredits.Crew;
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
                  'Movies',
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
              title: Text('Movies'),
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

class AllMovies extends StatefulWidget {
  final List<MoviesData> movies;

  AllMovies({@required this.movies});

  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies>
    with AutomaticKeepAliveClientMixin<AllMovies> {
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w92';

  void _navigateToMovieDetails(int id, String movieTitle) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => MovieDetails(
                      id: id,
                      movieTitle: movieTitle,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => MovieDetails(
                      id: id,
                      movieTitle: movieTitle,
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
                  widget.movies[index].id, widget.movies[index].title);
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
                          _imageBaseUrl + widget.movies[index].posterPath,
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
                            widget.movies[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8),
                          child: Text(
                            getMovieGenres(widget.movies[index].genreIds),
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
                              widget.movies[index].voteAverage,
                              widget.movies[index].voteCount),
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
        itemCount: widget.movies.length);
  }

  @override
  bool get wantKeepAlive => true;
}
