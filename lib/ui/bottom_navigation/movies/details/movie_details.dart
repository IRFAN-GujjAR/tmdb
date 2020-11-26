import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/bloc/home/movies/details/movie_details_bloc.dart';
import 'package:tmdb/bloc/home/movies/details/movie_details_events.dart';
import 'package:tmdb/bloc/home/movies/details/movie_details_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_states.dart';
import 'package:tmdb/bloc/login/login_state/login_state_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/common.dart' as models;
import 'package:tmdb/models/details/movie_details_data.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/movies/movie_details/movie_details_repo.dart';
import 'package:tmdb/repositories/home/tmdb/media_state/media_state_repo.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/favourite_media_repo.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/watch_list_media_repo.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/Rate.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/movies/collection/collection_details.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/see_all_cast_crew/see_all_cast_crew.dart';
import 'package:tmdb/ui/bottom_navigation/movies/see_all/see_all_movies.dart';
import 'package:tmdb/utils/dialogs/dialogs_utils.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';
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
  MovieDetailsBloc _movieDetailsBloc;
  MediaStateBloc _mediaStateBloc;
  StreamSubscription _mediaStateChangesSubscription;
  StreamSubscription _loginStateSubscription;

  String _currentPageTitle = '';

  Map<_CategoryItems, String> _categoryName = {
    _CategoryItems.castAndCrew: 'Cast & Crew',
    _CategoryItems.images: 'Images',
    _CategoryItems.videos: 'Videos',
    _CategoryItems.recommended: 'Recommended',
    _CategoryItems.similar: 'Similar'
  };

  @override
  void initState() {
    _movieDetailsBloc = MovieDetailsBloc(
        movieDetailsRepo: MovieDetailsRepo(client: getHttpClient(context)));
    _mediaStateBloc = MediaStateBloc(
        mediaStateRepo: MediaStateRepo(client: getHttpClient(context)));
    _initializeMovieDetails();
    _checkMovieState();
    _listenLoginStateChanges();
    _listenMediaStateChanges();
    super.initState();
  }

  void _listenLoginStateChanges() {
    _loginStateSubscription =
        BlocProvider.of<LoginStateBloc>(context).listen((state) {
      if (state is LoginStateLoggedIn) {
        _checkMovieState();
      }
    });
  }

  void _listenMediaStateChanges() {
    _mediaStateChangesSubscription =
        BlocProvider.of<MediaStateChangesBloc>(context).listen((state) {
      if (state is MediaStateChangesMovieChanged) {
        if (state.movieId == widget.id) _checkMovieState();
      }
    });
  }

  void _initializeMovieDetails() {
    _movieDetailsBloc.add(LoadMovieDetails(movieId: widget.id));
  }

  void _checkMovieState() {
    final loginInfoProvider =
        Provider.of<LoginInfoProvider>(context, listen: false);
    if (loginInfoProvider.isSignedIn) {
      _mediaStateBloc.add(LoadMediaState(
          url: URLS.movieStates(widget.id, loginInfoProvider.sessionId)));
    }
  }

  @override
  void dispose() {
    _movieDetailsBloc.close();
    _mediaStateBloc.close();
    _mediaStateChangesSubscription.cancel();
    _loginStateSubscription.cancel();
    super.dispose();
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

  void _navigateToSeeAllSimilarOrRecommendedMovies(BuildContext context,
      MoviesCategories moviesCategory, MoviesList moviesList) {
    NavigationUtils.navigate(
        context: context,
        page: SeeAllMovies(
          previousPageTitle: widget.movieTitle,
          category: moviesCategory,
          moviesList: moviesList,
          movieId: widget.id,
        ));
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
      BuildContext context, _CategoryItems item, MoviesList moviesList) {
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
                    context, MoviesCategories.DetailsRecommended, moviesList);
              } else if (item == _CategoryItems.similar) {
                _navigateToSeeAllSimilarOrRecommendedMovies(
                    context, MoviesCategories.DetailsSimilar, moviesList);
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

  void _navigateToCollectionDetails(BuildContext context, int id, String name) {
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
      BuildContext context, Collection collection, List<models.Genre> genres) {
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
            _navigateToCollectionDetails(
                context, collection.id, collection.name);
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

  void _navigateToCelebrityDetails(BuildContext context, int id, String name) {
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

  void _navigateToSeeAllCastCrew(BuildContext context, models.Credits credits) {
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

  Widget _buildTextRowForCastCrew(
      BuildContext context, _CategoryItems item, models.Credits credits) {
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
              _navigateToSeeAllCastCrew(context, credits);
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

  Widget _buildCastAndCrewItems(BuildContext context, models.Credits credits) {
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
        _buildTextRowForCastCrew(context, _CategoryItems.castAndCrew, credits),
        Container(
          height: 120,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToCelebrityDetails(
                        context, cast[index].id, cast[index].name);
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

  void _navigateToMovieDetails(BuildContext context, int id, String title) {
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
      BuildContext context, MoviesList moviesList, _CategoryItems item) {
    final int font = 12;

    final double listViewHeight = 200;
    final double imageHeight = 139;
    final double listItemWidth = 99;

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForSimilarOrRecommendedMovies(context, item, moviesList),
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
                  _navigateToMovieDetails(context, moviesList.movies[index].id,
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

  Widget _buildMovieDetailsWidget(MovieDetailsState movieDetailsState) {
    if (movieDetailsState is MovieDetailsLoaded) {
      final movie = movieDetailsState.movieDetailsData;
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
                        IMAGE_BASE_URL +
                            BackDropSizes.w780 +
                            movie.backdropPath,
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
                      Consumer<LoginInfoProvider>(
                          builder: (context, loginInfoProvider, _) {
                        return BlocBuilder<MediaStateBloc, MediaStateState>(
                            cubit: _mediaStateBloc,
                            builder: (context, state) {
                              final mediaState = state;
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: buildRatingWidget(
                                          movie.voteAverage, movie.voteCount)),
                                  Expanded(
                                    flex: loginInfoProvider.isSignedIn &&
                                            (mediaState is MediaStateLoaded) &&
                                            mediaState.mediaState.rated
                                        ? 1
                                        : 2,
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
                                          '${movie.voteAverage}',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  loginInfoProvider.isSignedIn &&
                                          mediaState is MediaStateLoaded
                                      ? mediaState.mediaState.rated
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
                                                    '${mediaState.mediaState.rating}',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container()
                                      : Container(),
                                ],
                              );
                            });
                      }),
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
                : _buildCollectionWidget(
                    context, movie.collection, movie.genres),
            movie.credits != null &&
                    movie.credits.cast != null &&
                    movie.credits.cast.isNotEmpty
                ? _buildCastAndCrewItems(context, movie.credits)
                : Container(),
            movie.videos.isNotEmpty
                ? _buildVideosItems(movie.videos)
                : Container(),
            _buildInformationWidget(movie),
            movie.recommendedMovies != null &&
                    movie.recommendedMovies.movies != null &&
                    movie.recommendedMovies.movies.isNotEmpty
                ? _buildRecommendedOrSimilarMovies(context,
                    movie.recommendedMovies, _CategoryItems.recommended)
                : Container(),
            movie.similarMovies != null &&
                    movie.similarMovies.movies != null &&
                    movie.similarMovies.movies.isNotEmpty
                ? _buildRecommendedOrSimilarMovies(
                    context, movie.similarMovies, _CategoryItems.similar)
                : Container(),
          ],
        ),
      );
    } else if (movieDetailsState is MovieDetailsLoadingError) {
      return InternetConnectionErrorWidget(onPressed: _initializeMovieDetails);
    }

    return LoadingWidget();
  }

  void onFavouriteClick(BuildContext context,
      LoginInfoProvider loginInfoProvider, MediaStateState mediaState) async {
    if (loginInfoProvider.isSignedIn) {
      if (mediaState is MediaStateLoaded) {
        final isFavourite = (mediaState).mediaState.favorite;
        if (isFavourite) {
          if (!await DialogUtils.showAlertDialog(
              context, 'Are you sure you want to remove it from favourite ?'))
            return;
        }
        var event;
        if (isFavourite)
          event = UnMarkFavouriteMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        else
          event = MarkFavouriteMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        context.read<FavouriteMediaBloc>().add(event);
      }
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void _onBookMarkClick(BuildContext context,
      LoginInfoProvider loginInfoProvider, MediaStateState mediaState) async {
    if (loginInfoProvider.isSignedIn) {
      if (mediaState is MediaStateLoaded) {
        final isWatchList = (mediaState).mediaState.watchlist;
        if (isWatchList) {
          if (!await DialogUtils.showAlertDialog(
              context, 'Are you sure you want to remove it from watchlist ?'))
            return;
        }
        var event;
        if (isWatchList)
          event = RemoveWatchListMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        else
          event = AddWatchListMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        context.read<WatchListMediaBloc>().add(event);
      }
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void _onRateClick(LoginInfoProvider loginInfoProvider) {
    if (loginInfoProvider.isSignedIn) {
      final movieDetails =
          (_movieDetailsBloc.state as MovieDetailsLoaded).movieDetailsData;
      final mediaState = (_mediaStateBloc.state as MediaStateLoaded).mediaState;
      NavigationUtils.navigate(
          context: context,
          page: Rate(
            mediaId: widget.id,
            titleOrName: movieDetails.title,
            posterPath: movieDetails.posterPath,
            backdropPath: movieDetails.backdropPath,
            rating: mediaState.rating.toInt(),
            isRated: mediaState.rated,
            mediaType: MediaType.Movie,
          ),
          rootNavigator: true);
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void get _notifyMovieStateChanges {
    context
        .read<MediaStateChangesBloc>()
        .add(NotifyMovieMediaStateChanges(movieId: widget.id));
  }

  List<Widget> get _buildMenuItems {
    final loginInfoProvider = Provider.of<LoginInfoProvider>(context);

    return <Widget>[
      BlocProvider<FavouriteMediaBloc>(
        create: (_) => FavouriteMediaBloc(
            favouriteMediaRepo: FavouriteMediaRepo(
                client: getHttpClient(context), mediaType: MediaType.Movie)),
        child: BlocConsumer<FavouriteMediaBloc, FavouriteMediaState>(
            listener: (context, favouriteMediaState) {
          if (favouriteMediaState is FavouriteMediaMarked) {
            _notifyMovieStateChanges;
          } else if (favouriteMediaState is FavouriteMediaUnMarked) {
            _notifyMovieStateChanges;
          } else if (favouriteMediaState is FavouriteMediaError) {
            DialogUtils.showMessageDialog(
                context, favouriteMediaState.error.toString());
          }
        }, builder: (context, favouriteMediaState) {
          return BlocBuilder<MediaStateBloc, MediaStateState>(
              cubit: _mediaStateBloc,
              builder: (context, mediaState) {
                final isEnable = (!(mediaState is MediaStateLoading) &&
                        !(favouriteMediaState is FavouriteMediaLoading)) ||
                    (!loginInfoProvider.isSignedIn);
                final showFavouriteFilledIcon = loginInfoProvider.isSignedIn &&
                    mediaState is MediaStateLoaded &&
                    mediaState.mediaState.favorite;

                return isIOS
                    ? CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: Icon(showFavouriteFilledIcon
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: isEnable
                            ? () {
                                onFavouriteClick(
                                    context, loginInfoProvider, mediaState);
                              }
                            : null,
                      )
                    : IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(showFavouriteFilledIcon
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.blue,
                        onPressed: isEnable
                            ? () {
                                onFavouriteClick(
                                    context, loginInfoProvider, mediaState);
                              }
                            : null,
                      );
              });
        }),
      ),
      BlocBuilder<MediaStateBloc, MediaStateState>(
          cubit: _mediaStateBloc,
          builder: (context, mediaState) {
            final showStarFilledIcon = (loginInfoProvider.isSignedIn &&
                mediaState is MediaStateLoaded &&
                mediaState.mediaState.rated);
            final isEnable = !(mediaState is MediaStateLoading) ||
                !loginInfoProvider.isSignedIn;
            return isIOS
                ? CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                        showStarFilledIcon ? Icons.star : Icons.star_border),
                    onPressed: isEnable
                        ? () {
                            _onRateClick(loginInfoProvider);
                          }
                        : null,
                  )
                : IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                        showStarFilledIcon ? Icons.star : Icons.star_border),
                    color: Colors.blue,
                    onPressed: isEnable
                        ? () {
                            _onRateClick(loginInfoProvider);
                          }
                        : null,
                  );
          }),
      BlocProvider<WatchListMediaBloc>(
        create: (_) => WatchListMediaBloc(
            watchListMediaRepo: WatchListMediaRepo(
                client: getHttpClient(context), mediaType: MediaType.Movie)),
        child: BlocConsumer<WatchListMediaBloc, WatchListMediaState>(
            listener: (context, watchListMediaState) {
              if (watchListMediaState is WatchListMediaAdded) {
                _notifyMovieStateChanges;
              } else if (watchListMediaState is WatchListMediaRemoved) {
                _notifyMovieStateChanges;
              } else if (watchListMediaState is WatchListMediaError) {
                DialogUtils.showMessageDialog(
                    context, watchListMediaState.error.toString());
              }
            },
            builder: (context, watchListMediaState) =>
                BlocBuilder<MediaStateBloc, MediaStateState>(
                  cubit: _mediaStateBloc,
                  builder: (context, mediaState) {
                    final isEnable = (!(mediaState is MediaStateLoading) &&
                            !(watchListMediaState is WatchListMediaLoading)) ||
                        (!loginInfoProvider.isSignedIn);
                    final showbookMarkFilledIcon =
                        loginInfoProvider.isSignedIn &&
                            mediaState is MediaStateLoaded &&
                            mediaState.mediaState.watchlist;

                    return isIOS
                        ? CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: Icon(showbookMarkFilledIcon
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            onPressed: isEnable
                                ? () {
                                    _onBookMarkClick(
                                        context, loginInfoProvider, mediaState);
                                  }
                                : null,
                          )
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(showbookMarkFilledIcon
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            color: Colors.blue,
                            onPressed: isEnable
                                ? () {
                                    _onBookMarkClick(
                                        context, loginInfoProvider, mediaState);
                                  }
                                : null,
                          );
                  },
                )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      cubit: _movieDetailsBloc,
      builder: (context, movieDetailsState) {
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
                    trailing: BlocBuilder<MediaStateBloc, MediaStateState>(
                      cubit: _mediaStateBloc,
                      builder: (context, mediaState) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: movieDetailsState is MovieDetailsLoaded
                              ? _buildMenuItems
                              : <Widget>[],
                        );
                      },
                    )),
                child: _buildMovieDetailsWidget(movieDetailsState))
            : Scaffold(
                appBar: AppBar(
                  title: Text(widget.movieTitle),
                  actions: movieDetailsState is MovieDetailsLoaded
                      ? _buildMenuItems
                      : <Widget>[],
                ),
                body: _buildMovieDetailsWidget(movieDetailsState));
      },
    );
  }
}
