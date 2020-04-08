import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/bottom_navigation/common/rating/Rate.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/collection/collection_details.dart';
import 'package:tmdb/bottom_navigation/movies/details/see_all_cast_crew/see_all_cast_crew.dart';
import 'package:tmdb/bottom_navigation/movies/see_all/see_all_movies.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/common.dart' as models;
import 'package:tmdb/models/details/movie_details_data.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/details_api.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/network/tmdb_account/tmdb_account_api.dart';
import 'package:tmdb/provider/movie_provider.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum _CategoryItems { castAndCrew, images, videos, recommended, similar }

class MovieDetails extends StatefulWidget {
  final int id;
  final String movieTitle;
  final String previousPageTitle;

  MovieDetails(
      {Key key,
      @required this.id,
      @required this.movieTitle,
      @required this.previousPageTitle})
      : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  String _currentPageTitle = '';

  Map<_CategoryItems, String> _categoryName = {
    _CategoryItems.castAndCrew: 'Cast & Crew',
    _CategoryItems.images: 'Images',
    _CategoryItems.videos: 'Videos',
    _CategoryItems.recommended: 'Recommended',
    _CategoryItems.similar: 'Similar'
  };

  MovieDetailsData _movieDetailsData;
  bool _isMovieDataLoaded = false;
  bool _isTMDbDataLoaded = false;
  bool _isMovieFavourite = false;
  bool _isMovieAddedToWatchList = false;
  bool _isMovieRated = false;
  int _rating = 0;

  bool _isSignedIn = false;
  String _sessionId = '', _accountId = '';

  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeMovieDetails();
        _checkTMDbData();
      }
    });
    _initializeMovieDetails();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _initializeMovieDetails() async {
    setState(() {
      _isMovieDataLoaded = false;
    });
    _movieDetailsData = await fetchMovieDetails(http.Client(), widget.id);
    if (_movieDetailsData == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      setState(() {
        _isInternet = true;
      });
    }
    setState(() {
      _isMovieDataLoaded = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  Future<void> _checkMovieIsFavourite() async {
    _isMovieFavourite = await checkMovieIsFavourite(
        http.Client(), _sessionId, _accountId, widget.id);
  }

  Future<void> _checkMovieIsAddedToWatchList() async {
    _isMovieAddedToWatchList = await checkMovieIsAddedToWatchList(
        http.Client(), _sessionId, _accountId, widget.id);
  }

  Future<void> _checkMovieIsRated() async {
    _rating = await checkMovieIsRated(
        http.Client(), _sessionId, _accountId, widget.id);
    setState(() {
      _isMovieRated = _rating != 0 ? true : false;
    });
  }

  Widget _buildGenresWidgets(List<models.Genre> genres) {
    if (genres.isNotEmpty) {
      return Container(
        height: 30,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Text(genres[index].name,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: genres.length),
      );
    } else {
      return null;
    }
  }

  Widget get _divider {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 15.0),
      height: 0.5,
      color: Colors.grey[900],
    );
  }

  void _navigateToSeeAllSimilarOrRecommendedMovies(
      MoviesCategories moviesCategory, MoviesList moviesList) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return SeeAllMovies(
                  previousPageTitle: widget.movieTitle,
                  category: moviesCategory,
                  moviesList: moviesList,
                  movieId: widget.id,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return SeeAllMovies(
                  previousPageTitle: widget.movieTitle,
                  category: moviesCategory,
                  moviesList: moviesList,
                  movieId: widget.id,
                );
              }));
  }

  Widget _buildTextRow(_CategoryItems item) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          item != _CategoryItems.videos
              ? CupertinoButton(
                  onPressed: () {},
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
              : Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                )
        ],
      ),
    );
  }

  Widget _buildTextRowForSimilarOrRecommendedMovies(
      _CategoryItems item, MoviesList moviesList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              if (item == _CategoryItems.recommended) {
                _navigateToSeeAllSimilarOrRecommendedMovies(
                    MoviesCategories.DetailsRecommended, moviesList);
              } else if (item == _CategoryItems.similar) {
                _navigateToSeeAllSimilarOrRecommendedMovies(
                    MoviesCategories.DetailsSimilar, moviesList);
              }
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

  void _navigateToCollectionDetails(int id, String name) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return CollectionDetails(
                  id: id,
                  name: name,
                  previousPageTitle: _currentPageTitle,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return CollectionDetails(
                  id: id,
                  name: name,
                  previousPageTitle: _currentPageTitle,
                );
              }));
  }

  Widget _buildCollectionWidget(
      Collection collection, List<models.Genre> genres) {
    if (collection.posterPath == null) {
      return Container();
    }

    String genresText = '';

    if (genres != null && genres.isNotEmpty) {
      for (int i = 0; i < genres.length; i++) {
        genresText.isEmpty
            ? genresText = genres[i].name
            : genresText = genresText + ', ' + genres[i].name;
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 15),
          child: Text('Collection',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
        ),
        GestureDetector(
          onTap: () {
            _navigateToCollectionDetails(collection.id, collection.name);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 0, style: BorderStyle.none)),
            child: Row(
              children: <Widget>[
                Container(
                    height: 100,
                    width: 80,
                    margin: const EdgeInsets.only(left: 8.0, top: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3)),
                    child: Image.network(
                      IMAGE_BASE_URL + PosterSizes.w185 + collection.posterPath,
                      fit: BoxFit.fitWidth,
                    )),
                Container(
                  width: 240,
                  margin: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        collection.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14),
                      ),
                      genresText.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                genresText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    CupertinoIcons.forward,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _navigateToCelebrityDetails(int id, String name) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return CelebritiesDetails(
                  id: id,
                  celebName: name,
                  previousPageTitle: _currentPageTitle,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return CelebritiesDetails(
                  id: id,
                  celebName: name,
                  previousPageTitle: _currentPageTitle,
                );
              }));
  }

  void _navigateToSeeAllCastCrew(models.Credits credits) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeeAllCastCrew(
                      previousPageTitle: widget.movieTitle,
                      credits: credits,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeeAllCastCrew(
                      previousPageTitle: widget.movieTitle,
                      credits: credits,
                    )));
  }

  Widget _buildTextRowForCastCrew(_CategoryItems item, models.Credits credits) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllCastCrew(credits);
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

  Widget _buildCastAndCrewItems(models.Credits credits) {
    List<models.Cast> cast = credits.cast;
    int length = 0;

    if (cast.length <= 15) {
      length = cast.length;
    } else {
      length = 15;
    }

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForCastCrew(_CategoryItems.castAndCrew, credits),
        Container(
          height: 120,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToCelebrityDetails(
                        cast[index].id, cast[index].name);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: cast[index].profilePath == null
                                  ? Icon(
                                      CupertinoIcons.person_solid,
                                      color: Colors.grey,
                                      size: 75,
                                    )
                                  : Image.network(
                                      IMAGE_BASE_URL +
                                          ProfileSizes.w185 +
                                          cast[index].profilePath,
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            cast[index].name,
                            style: TextStyle(fontSize: 13),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            cast[index].character,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: length),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    url = 'https://www.youtube.com/watch?v=' + url;
    if (isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget _buildVideosItems(List<models.Video> videos) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        _buildTextRow(_CategoryItems.videos),
        Container(
          height: 90,
          child: ListView.separated(
              padding: const EdgeInsets.only(right: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _launchURL(videos[index].key);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 90,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          getThumbnail(videoId: videos[index].key),
                          fit: BoxFit.fill,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 31,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 0.9])),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 20,
                              margin:
                                  const EdgeInsets.only(right: 6.0, bottom: 4),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: SvgPicture.asset(
                                'assets/icons/youtube.svg',
                                width: 15,
                                height: 15,
                                color: Colors.red[900],
                                colorBlendMode: BlendMode.color,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemCount: videos.length),
        ),
      ],
    );
  }

  Widget _buildInformationWidget(MovieDetailsData movie) {
    if (movie.releaseDate == null &&
        movie.language == null &&
        movie.budget == '0' &&
        movie.revenue == '0' &&
        movie.productionCompanies == null &&
        movie.productionCompanies.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 13),
          child: Text('Information'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  movie.releaseDate != null
                      ? _buildInformationWidgetItemTitle('Release Date')
                      : Container(),
                  movie.language != null
                      ? _buildInformationWidgetItemTitle('Language')
                      : Container(),
                  movie.budget != '0'
                      ? _buildInformationWidgetItemTitle('Budget')
                      : Container(),
                  movie.revenue != '0'
                      ? _buildInformationWidgetItemTitle('Revenue')
                      : Container(),
                  movie.productionCompanies != null &&
                          movie.productionCompanies.isNotEmpty
                      ? _buildInformationWidgetItemTitle('Production Companies')
                      : Container()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  movie.releaseDate != null
                      ? _buildInformationWidgetItemData(movie.releaseDate)
                      : Container(),
                  movie.language != null
                      ? _buildInformationWidgetItemData(movie.language)
                      : Container(),
                  movie.budget != '0'
                      ? _buildInformationWidgetItemData(movie.budget)
                      : Container(),
                  movie.revenue != '0'
                      ? _buildInformationWidgetItemData(movie.revenue)
                      : Container(),
                  movie.productionCompanies != null &&
                          movie.productionCompanies.isNotEmpty
                      ? _buildProductionCompaniesItems(
                          movie.productionCompanies)
                      : Container(),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInformationWidgetItemTitle(String category) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
        category,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildInformationWidgetItemData(String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Text(
        data,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _buildProductionCompaniesItems(
      List<models.ProductionCompany> productionCompanies) {
    List<Text> items = productionCompanies.map((productionCompany) {
      return Text(
        productionCompany.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  void _navigateToMovieDetails(int id, String title) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return MovieDetails(
                  id: id,
                  movieTitle: title,
                  previousPageTitle: _currentPageTitle,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return MovieDetails(
                  id: id,
                  movieTitle: title,
                  previousPageTitle: _currentPageTitle,
                );
              }));
  }

  Widget _buildRecommendedOrSimilarMovies(
      MoviesList moviesList, _CategoryItems item) {
    final int font = 12;

    final double listViewHeight = 200;
    final double imageHeight = 139;
    final double listItemWidth = 99;

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForSimilarOrRecommendedMovies(item, moviesList),
        Container(
          height: listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount:
                moviesList.movies.length < 20 ? moviesList.movies.length : 20,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 8,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              int length = moviesList.movies.length >= 20
                  ? 19
                  : moviesList.movies.length - 1;
              return GestureDetector(
                onTap: () {
                  _navigateToMovieDetails(moviesList.movies[index].id,
                      moviesList.movies[index].title);
                },
                child: Container(
                  margin: index == length
                      ? const EdgeInsets.only(left: 10, right: 10)
                      : const EdgeInsets.only(left: 10),
                  width: listItemWidth,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: imageHeight,
                          width: listItemWidth,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3, color: Colors.grey),
                          ),
                          child: Image.network(
                              IMAGE_BASE_URL +
                                  PosterSizes.w185 +
                                  moviesList.movies[index].posterPath,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              moviesList.movies[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: font.toDouble()),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              getMovieGenres(moviesList.movies[index].genreIds),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMovieDetailsWidget(MovieDetailsData movie) {
    _currentPageTitle = movie.title;

    final EdgeInsets padding = MediaQuery.of(context).padding;
    final bottomPadding = padding.bottom + 30;
    final topPadding = padding.top + kToolbarHeight;

    return SingleChildScrollView(
      padding: isIOS
          ? EdgeInsets.only(bottom: bottomPadding, top: topPadding)
          : const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 0)
                    : const EdgeInsets.only(top: 10),
                child: Container(
                    width: double.infinity,
                    height: 211,
                    child: Image.network(
                      IMAGE_BASE_URL + BackDropSizes.w780 + movie.backdropPath,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 136)
                    : const EdgeInsets.only(top: 150),
                child: Container(
                  width: double.infinity,
                  height: 76,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.9])),
                ),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(left: 5, top: 192)
                    : const EdgeInsets.only(left: 5, top: 202),
                child: Container(
                    width: 92,
                    height: 136,
                    child: Image.network(
                      IMAGE_BASE_URL + PosterSizes.w185 + movie.posterPath,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(left: 100, top: 190, right: 20)
                    : const EdgeInsets.only(left: 100, top: 200, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        movie.title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            flex: 3,
                            child: buildRatingWidget(
                                movie.voteAverage, movie.voteCount)),
                        Expanded(
                          flex: _isMovieRated ? 1 : 2,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${_movieDetailsData.voteAverage}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        _isMovieRated && _isSignedIn
                            ? Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '$_rating',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    movie.genres != null && movie.genres.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: _buildGenresWidgets(movie.genres),
                          )
                        : Container(),
                    movie.overview != null && movie.overview.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: Text(
                              movie.overview,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
          movie.collection == null
              ? Container()
              : _buildCollectionWidget(movie.collection, movie.genres),
          movie.credits != null &&
                  movie.credits.cast != null &&
                  movie.credits.cast.isNotEmpty
              ? _buildCastAndCrewItems(movie.credits)
              : Container(),
          movie.videos.isNotEmpty
              ? _buildVideosItems(movie.videos)
              : Container(),
          _buildInformationWidget(movie),
          movie.recommendedMovies != null &&
                  movie.recommendedMovies.movies != null &&
                  movie.recommendedMovies.movies.isNotEmpty
              ? _buildRecommendedOrSimilarMovies(
                  movie.recommendedMovies, _CategoryItems.recommended)
              : Container(),
          movie.similarMovies != null &&
                  movie.similarMovies.movies != null &&
                  movie.similarMovies.movies.isNotEmpty
              ? _buildRecommendedOrSimilarMovies(
                  movie.similarMovies, _CategoryItems.similar)
              : Container(),
        ],
      ),
    );
  }

  void _addMovieToWatchList(BuildContext context, bool addToWatchList,
      MovieTvShowProvider movieProvider) async {
    if (_isSignedIn) {
      bool deleteMovie = false;

      if (!addToWatchList) {
        deleteMovie = await _showAlertDialog('Watchlist');
      }

      if (deleteMovie || addToWatchList) {
        bool isMovieAddedToWatchList = await addMovieToWatchList(
            http.Client(), _sessionId, _accountId, widget.id, addToWatchList);
        if (isMovieAddedToWatchList != null) {
          movieProvider.addMovie(MediaTMDbData(
              id: widget.id,
              isAddedToFavorite: _isMovieFavourite,
              isRated: _isMovieRated,
              rating: _rating,
              isAddedToWatchList: isMovieAddedToWatchList));
        } else {
          showInternetConnectionFailureError(context);
        }
      }
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  void _navigateToRate(BuildContext context) {
    if (_isSignedIn) {
      Navigator.of(context).push(isIOS
          ? CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => Rate(
                    mediaId: widget.id,
                    titleOrName: _movieDetailsData.title,
                    posterPath: _movieDetailsData.posterPath,
                    backdropPath: _movieDetailsData.backdropPath,
                    rating: _rating,
                    ratingCategory: RatingCategory.Movie,
                  ))
          : MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => Rate(
                    mediaId: widget.id,
                    titleOrName: _movieDetailsData.title,
                    posterPath: _movieDetailsData.posterPath,
                    backdropPath: _movieDetailsData.backdropPath,
                    rating: _rating,
                    ratingCategory: RatingCategory.Movie,
                  )));
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  Future<bool> _showAlertDialog(String category) async {
    bool yes = false;

    isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(
                    'Are you sure you want to remove it from $category ? '),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                content: Text(
                    'Are you sure you want to remove it from $category ? '),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });

    return yes;
  }

  void _markMovieFavourite(BuildContext context, bool markFavourite,
      MovieTvShowProvider movieProvider) async {
    if (_isSignedIn) {
      bool deleteMovie = false;

      if (!markFavourite) {
        deleteMovie = await _showAlertDialog('Favorite');
      }

      if (deleteMovie || markFavourite) {
        bool isMovieFavourite = await markMovieAsFavourite(http.Client(),
            widget.id.toString(), _accountId, _sessionId, markFavourite);
        if (isMovieFavourite != null) {
          movieProvider.addMovie(MediaTMDbData(
              id: widget.id,
              isAddedToFavorite: isMovieFavourite,
              isRated: _isMovieRated,
              rating: _rating,
              isAddedToWatchList: _isMovieAddedToWatchList));
        } else {
          showInternetConnectionFailureError(context);
        }
      }
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  MovieTvShowProvider _movieTvShowProvider;

  void _checkTMDbData() async {
    _firstTimeLoaded = false;
    await _checkMovieIsFavourite();
    await _checkMovieIsRated();
    await _checkMovieIsAddedToWatchList();
    if (_isMovieFavourite || _isMovieRated || _isMovieAddedToWatchList) {
      _movieTvShowProvider.addMovie(MediaTMDbData(
          id: widget.id,
          isAddedToFavorite: _isMovieFavourite,
          isRated: _isMovieRated,
          rating: _rating,
          isAddedToWatchList: _isMovieAddedToWatchList));
    }
    setState(() {
      _isTMDbDataLoaded = true;
    });
  }

  bool _firstTimeLoaded = true;

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    _sessionId = loginInfoProvider.sessionId;
    _accountId = loginInfoProvider.accountId;
    if (_firstTimeLoaded ||
        ((loginInfoProvider.isSignedIn != _isSignedIn) &&
            (loginInfoProvider.isSignedIn))) {
      _checkTMDbData();
    }
    _isSignedIn = loginInfoProvider.isSignedIn;

    _movieTvShowProvider = Provider.of<MovieTvShowProvider>(context);
    MediaTMDbData mediaTMDbData =
        _movieTvShowProvider.getMovieTMDbData(widget.id);
    if (mediaTMDbData != null) {
      _isMovieFavourite = mediaTMDbData.isAddedToFavorite;
      _isMovieRated = mediaTMDbData.isRated;
      _rating = mediaTMDbData.rating == null ? 0 : mediaTMDbData.rating;
      _isMovieAddedToWatchList = mediaTMDbData.isAddedToWatchList;
    } else if (!_isSignedIn) {
      _isMovieFavourite = false;
      _isMovieRated = false;
      _rating = 0;
      _isMovieAddedToWatchList = false;
    }

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.movieTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: _isMovieDataLoaded && _isInternet
                    ? <Widget>[
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isMovieFavourite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _markMovieFavourite(context,
                                      !_isMovieFavourite, _movieTvShowProvider);
                                },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isMovieRated
                              ? Icons.star
                              : Icons.star_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _navigateToRate(context);
                                },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isMovieAddedToWatchList
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _addMovieToWatchList(
                                      context,
                                      !_isMovieAddedToWatchList,
                                      _movieTvShowProvider);
                                },
                        ),
                      ]
                    : <Widget>[],
              ),
            ),
            child: _isMovieDataLoaded
                ? _isInternet
                    ? _buildMovieDetailsWidget(_movieDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeMovieDetails,
                      )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.movieTitle),
              actions: _isMovieDataLoaded && _isInternet
                  ? <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isMovieFavourite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _markMovieFavourite(context, !_isMovieFavourite,
                                    _movieTvShowProvider);
                              },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isMovieRated
                            ? Icons.star
                            : Icons.star_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _navigateToRate(context);
                              },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isMovieAddedToWatchList
                            ? Icons.bookmark
                            : Icons.bookmark_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _addMovieToWatchList(
                                    context,
                                    !_isMovieAddedToWatchList,
                                    _movieTvShowProvider);
                              },
                      )
                    ]
                  : <Widget>[],
            ),
            body: _isMovieDataLoaded
                ? _isInternet
                    ? _buildMovieDetailsWidget(_movieDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeMovieDetails,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          );
  }
}
