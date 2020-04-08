import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/celebrities/details/see_all_movies_credits/see_all_movie_credits.dart';
import 'package:tmdb/bottom_navigation/celebrities/details/see_all_tv_credits/see_all_tv_credits.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/models/details/celebrities_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/network/details_api.dart';
import 'package:tmdb/utils/utils.dart';

import '../../../main.dart';

enum _CategoryItems { movies, tvShows }

class CelebritiesDetails extends StatefulWidget {
  final int id;
  final String celebName;
  final String previousPageTitle;

  CelebritiesDetails(
      {@required this.id,
      @required this.celebName,
      @required this.previousPageTitle});

  @override
  _CelebritiesDetailsState createState() => _CelebritiesDetailsState();
}

class _CelebritiesDetailsState extends State<CelebritiesDetails> {
  Map<_CategoryItems, String> _categoryName = {
    _CategoryItems.movies: 'Movies',
    _CategoryItems.tvShows: 'Tv Shows'
  };

  CelebritiesDetailsData _celebrityDetailsData;
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
        _initializeCelebrityDetails();
      }
    });
    _initializeCelebrityDetails();
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

  void _initializeCelebrityDetails() async {
    setState(() {
      _isDataLoaded = false;
    });
    _celebrityDetailsData =
        await fetCelebrityDetails(http.Client(), widget.id);
    if (_celebrityDetailsData == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      setState(() {
        _isInternet = true;
      });
    }
    setState(() {
      _isDataLoaded = true;
    });
  }

  Widget get _divider {
    return Container(
      margin: const EdgeInsets.only(left: 12, top: 15.0),
      height: 0.5,
      color: Colors.grey[900],
    );
  }

  Widget _buildTextRow(
      _CategoryItems item, MovieCredits movieCredits, TvCredits tvCredits) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              Navigator.push(
                  context,
                  isIOS
                      ? CupertinoPageRoute(builder: (context) {
                          return item == _CategoryItems.movies
                              ? SeeAllMovieCredits(
                                  previousPageTitle: widget.celebName,
                                  movieCredits: movieCredits,
                                )
                              : SeeAllTvCredits(
                                  previousPageTitle: widget.celebName,
                                  tvCredits: tvCredits,
                                );
                        })
                      : MaterialPageRoute(builder: (context) {
                          return item == _CategoryItems.movies
                              ? SeeAllMovieCredits(
                                  previousPageTitle: widget.celebName,
                                  movieCredits: movieCredits,
                                )
                              : SeeAllTvCredits(
                                  previousPageTitle: widget.celebName,
                                  tvCredits: tvCredits,
                                );
                        }));
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

  Widget _buildTvShowsWidget(TvCredits tvCredits) {
    if ((tvCredits.cast == null || tvCredits.cast.isEmpty) &&
        (tvCredits.crew == null || tvCredits.crew.isEmpty)) {
      return Container();
    }

    List<TvShowsData> tvShows;

    if (tvCredits.cast == null || tvCredits.cast.isEmpty) {
      tvShows = tvCredits.crew;
    } else {
      tvShows = tvCredits.cast;
    }

    int length;

    if (tvShows.length < 20) {
      length = tvShows.length;
    } else {
      length = 20;
    }

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRow(_CategoryItems.tvShows, null, tvCredits),
        Container(
          height: 190,
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        isIOS
                            ? CupertinoPageRoute(
                                builder: (context) => TvShowDetails(
                                      id: tvShows[index].id,
                                      tvShowTitle: tvShows[index].name,
                                      previousPageTitle: widget.celebName,
                                    ))
                            : MaterialPageRoute(
                                builder: (context) => TvShowDetails(
                                      id: tvShows[index].id,
                                      tvShowTitle: tvShows[index].name,
                                      previousPageTitle: widget.celebName,
                                    )));
                  },
                  child: Container(
                    margin: index == length - 1
                        ? const EdgeInsets.only(left: 12, right: 12)
                        : const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.none)),
                    width: 92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 92,
                          height: 136,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.3)),
                          child: Image.network(
                            IMAGE_BASE_URL +
                                PosterSizes.w185 +
                                tvShows[index].posterPath,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            tvShows[index].name,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            getMovieGenres(tvShows[index].genreIds),
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: length),
        )
      ],
    );
  }

  Widget _buildMoviesWidget(MovieCredits movieCredits) {
    if ((movieCredits.cast == null || movieCredits.cast.isEmpty) &&
        (movieCredits.crew == null || movieCredits.crew.isEmpty)) {
      return Container();
    }

    List<MoviesData> movies;

    if (movieCredits.cast == null || movieCredits.cast.isEmpty) {
      movies = movieCredits.crew;
    } else {
      movies = movieCredits.cast;
    }

    int length;

    if (movies.length < 20) {
      length = movies.length;
    } else {
      length = 20;
    }

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRow(_CategoryItems.movies, movieCredits, null),
        Container(
          height: 190,
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        isIOS
                            ? CupertinoPageRoute(
                                builder: (context) => MovieDetails(
                                      id: movies[index].id,
                                      movieTitle: movies[index].title,
                                      previousPageTitle: widget.celebName,
                                    ))
                            : MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                      id: movies[index].id,
                                      movieTitle: movies[index].title,
                                      previousPageTitle: widget.celebName,
                                    )));
                  },
                  child: Container(
                    margin: index == length - 1
                        ? const EdgeInsets.only(left: 12, right: 12)
                        : const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.none)),
                    width: 92,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 92,
                          height: 136,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.3)),
                          child: Image.network(
                            IMAGE_BASE_URL +
                                PosterSizes.w185 +
                                movies[index].posterPath,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            movies[index].title,
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            getMovieGenres(movies[index].genreIds),
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 8,
                );
              },
              itemCount: length),
        )
      ],
    );
  }

  Widget _buildBiographyWidget(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 15.0),
          child: Text(
            'Biography',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 10, right: 12),
          child: Text(
            overview,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 11),
          ),
          Container(
            width: 220,
            child: Text(
              data,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCelebrityDetailsWidget(CelebritiesDetailsData celebrity) {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final bottomPadding = padding.bottom + 30;
    final topPadding = padding.top + kToolbarHeight + 10;

    return SingleChildScrollView(
      padding: isIOS
          ? EdgeInsets.only(top: topPadding, bottom: bottomPadding)
          : const EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                celebrity.profilePath != null
                    ? Container(
                        width: 130,
                        height: 194,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(17)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(17),
                          child: celebrity.profilePath != null &&
                                  celebrity.profilePath.isNotEmpty
                              ? Image.network(
                                  IMAGE_BASE_URL +
                                      ProfileSizes.w185 +
                                      celebrity.profilePath,
                                  fit: BoxFit.fill,
                                )
                              : Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                  size: 100,
                                ),
                        ))
                    : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 70,
                        ),
                      ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          celebrity.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        celebrity.department != null &&
                                celebrity.department.isNotEmpty
                            ? _buildDescriptionWidget(
                                'known for', celebrity.department)
                            : Container(),
                        celebrity.birthPlace != null &&
                                celebrity.birthPlace.isNotEmpty
                            ? _buildDescriptionWidget(
                                'Birthplace', celebrity.birthPlace)
                            : Container(),
                        celebrity.birthday != null &&
                                celebrity.birthday.isNotEmpty
                            ? _buildDescriptionWidget(
                                'Date of Birth', celebrity.birthday)
                            : Container(),
                        celebrity.deathDay != null &&
                                celebrity.deathDay.isNotEmpty
                            ? _buildDescriptionWidget(
                                'Death day', celebrity.deathDay)
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          celebrity.biography != null && celebrity.biography.isNotEmpty
              ? _buildBiographyWidget(celebrity.biography)
              : Container(),
          celebrity.movieCredits != null
              ? _buildMoviesWidget(celebrity.movieCredits)
              : Container(),
          celebrity.tvCredits != null
              ? _buildTvShowsWidget(celebrity.tvCredits)
              : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.celebName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _isDataLoaded
                ? _isInternet
                    ? _buildCelebrityDetailsWidget(_celebrityDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeCelebrityDetails,
                      )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ))
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.celebName),
            ),
            body: _isDataLoaded
                ? _isInternet
                    ? _buildCelebrityDetailsWidget(_celebrityDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeCelebrityDetails,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
