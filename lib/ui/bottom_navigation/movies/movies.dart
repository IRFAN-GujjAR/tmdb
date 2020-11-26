import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/movies_bloc.dart';
import 'package:tmdb/bloc/home/movies/movies_events.dart';
import 'package:tmdb/bloc/home/movies/movies_states.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/repositories/home/movies/movies_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/ui/bottom_navigation/movies/see_all/see_all_movies.dart';
import 'package:tmdb/ui/movie_tv_show_app.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

import '../../../main.dart';

Map<MoviesCategories, String> movieCategoryName = {
  MoviesCategories.Popular: 'Popular',
  MoviesCategories.InTheatres: 'Playing In Theatres',
  MoviesCategories.Trending: 'Trending',
  MoviesCategories.TopRated: 'Top Rated',
  MoviesCategories.Upcoming: 'Upcoming',
  MoviesCategories.DetailsRecommended: 'Recommended',
  MoviesCategories.DetailsSimilar: 'Similar'
};

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  MoviesBloc _moviesBloc;

  @override
  void initState() {
    _moviesBloc =
        MoviesBloc(moviesRepo: MoviesRepo(client: getHttpClient(context)));
    _initializeMovies();
    super.initState();
  }

  void _initializeMovies() {
    _moviesBloc.add(MoviesEvents.Load);
  }

  @override
  void dispose() {
    _moviesBloc.close();
    super.dispose();
  }

  void _navigateToSeeAllMovies(
      BuildContext context, MoviesCategories category, MoviesList moviesList) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeeAllMovies(
                      previousPageTitle: 'Movies',
                      category: category,
                      moviesList: moviesList,
                      movieId: null,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeeAllMovies(
                      previousPageTitle: 'Movies',
                      category: category,
                      moviesList: moviesList,
                      movieId: null,
                    )));
  }

  Widget _buildTextRow(
      BuildContext context, MoviesCategories category, MoviesList moviesList) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            movieCategoryName[category],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllMovies(context, category, moviesList);
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

  Widget _divider(MoviesCategories category) {
    return Container(
      margin: getDividerMargin(category),
      height: 0.8,
      color: Colors.grey[900],
    );
  }

  EdgeInsets getDividerMargin(MoviesCategories category) {
    if (category == MoviesCategories.Popular) {
      return const EdgeInsets.only(left: 12, top: 5.0);
    } else if (category == MoviesCategories.InTheatres) {
      return const EdgeInsets.only(left: 12, top: 12.0);
    } else if (category == MoviesCategories.Trending) {
      return const EdgeInsets.only(left: 12, top: 10.0);
    } else {
      return const EdgeInsets.only(left: 12, top: 20.0);
    }
  }

  void _navigateToMovieDetails(BuildContext context, MoviesData movie) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => MovieDetails(
                      id: movie.id,
                      movieTitle: movie.title,
                      previousPageTitle: 'Movies',
                    ))
            : MaterialPageRoute(
                builder: (context) => MovieDetails(
                      id: movie.id,
                      movieTitle: movie.title,
                      previousPageTitle: 'Movies',
                    )));
  }

  Widget _buildCategoryWidgets(
      BuildContext context, MoviesCategories category, MoviesList moviesList) {
    List<MoviesData> movies = moviesList.movies;

    _MoviesItemConfiguration moviesItemConfiguration =
        _MoviesItemConfiguration(category: category);

    int font = 12;
    if (category == MoviesCategories.Popular) {
      font = 13;
    } else if (category == MoviesCategories.InTheatres) {
      font = 15;
    } else {
      font = 12;
    }

    return Column(
      children: <Widget>[
        _buildTextRow(context, category, moviesList),
        Container(
          height: moviesItemConfiguration.listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length < 20 ? movies.length : 20,
            padding: const EdgeInsets.only(left: 12, right: 12),
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 20,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: moviesItemConfiguration.listItemWidth,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _navigateToMovieDetails(context, movies[index]);
                      },
                      child: Container(
                          height: moviesItemConfiguration.imageHeight,
                          width: moviesItemConfiguration.listItemWidth,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3, color: Colors.grey),
                          ),
                          child: category == MoviesCategories.InTheatres
                              ? Image.network(
                                  moviesItemConfiguration.imageUrl +
                                      movies[index].backdropPath,
                                  fit: BoxFit.fill)
                              : Image.network(
                                  moviesItemConfiguration.imageUrl +
                                      movies[index].posterPath,
                                  fit: BoxFit.fill)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: Text(
                            movies[index].title,
                            maxLines:
                                category == MoviesCategories.InTheatres ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: font.toDouble()),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    movies[index].genreIds != null &&
                            movies[index].genreIds.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.0),
                                child: Text(
                                  getMovieGenres(movies[index].genreIds),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: category ==
                                              MoviesCategories.InTheatres
                                          ? 12
                                          : 11),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              );
            },
          ),
        ),
        category != MoviesCategories.Upcoming ? _divider(category) : Container()
      ],
    );
  }

  Widget _buildTopRatedItems(BuildContext context, MoviesData movie) {
    return GestureDetector(
      onTap: () {
        _navigateToMovieDetails(context, movie);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(width: 0, style: BorderStyle.none)),
        child: Row(
          children: <Widget>[
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5)),
                child: Image.network(
                  IMAGE_BASE_URL + PosterSizes.w92 + movie.posterPath,
                  fit: BoxFit.fitWidth,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
                movie.genreIds != null && movie.genreIds.isNotEmpty
                    ? Container(
                        width: 190,
                        margin: const EdgeInsets.only(left: 8.0, top: 4),
                        child: Text(
                          getMovieGenres(movie.genreIds),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : Container(),
              ],
            ),
            Spacer(),
            Icon(
              CupertinoIcons.forward,
              color: Colors.grey,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopRatedMovies(
      BuildContext context, MoviesCategories category, MoviesList moviesList) {
    List<MoviesData> movies = moviesList.movies;

    List<MoviesData> firstPairMovies;
    List<MoviesData> secondPairMovies;
    List<MoviesData> thirdPairMovies;

    for (int i = 0; i < 12; i++) {
      if (i >= 0 && i <= 3) {
        if (firstPairMovies == null) {
          firstPairMovies = [movies[i]];
        } else {
          firstPairMovies.add(movies[i]);
        }
      } else if (i >= 4 && i <= 7) {
        if (secondPairMovies == null) {
          secondPairMovies = [movies[i]];
        } else {
          secondPairMovies.add(movies[i]);
        }
      } else if (i >= 8 && i <= 11) {
        if (thirdPairMovies == null) {
          thirdPairMovies = [movies[i]];
        } else {
          thirdPairMovies.add(movies[i]);
        }
      }
    }

    return Column(
      children: <Widget>[
        _buildTextRow(context, category, moviesList),
        Container(
          height: 200,
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int mainIndex) {
                return Container(
                  margin: const EdgeInsets.only(left: 12),
                  width: 310,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _getTopRatedItems(context, mainIndex, 0, firstPairMovies,
                          secondPairMovies, thirdPairMovies),
                      _getTopRatedItems(context, mainIndex, 1, firstPairMovies,
                          secondPairMovies, thirdPairMovies),
                      _getTopRatedItems(context, mainIndex, 2, firstPairMovies,
                          secondPairMovies, thirdPairMovies),
                      _getTopRatedItems(context, mainIndex, 3, firstPairMovies,
                          secondPairMovies, thirdPairMovies),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  width: 8,
                );
              },
              itemCount: 3),
        ),
        _divider(category),
      ],
    );
  }

  Widget _getTopRatedItems(
    BuildContext context,
    int mainIndex,
    int itemIndex,
    List<MoviesData> firstPairMovies,
    List<MoviesData> secondPairMovies,
    List<MoviesData> thirdPairMovies,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTopRatedItems(context, firstPairMovies[itemIndex]);
      case 1:
        return _buildTopRatedItems(context, secondPairMovies[itemIndex]);
      case 2:
        return _buildTopRatedItems(context, thirdPairMovies[itemIndex]);
    }

    return Container();
  }

  Widget get _buildMoviesWidget {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double bottomPadding = padding.bottom + 20;

    return BlocBuilder<MoviesBloc, MoviesState>(
        cubit: _moviesBloc,
        builder: (context, moviesState) {
          if (moviesState is MoviesLoaded) {
            final moviesLists = moviesState.movies;
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: isIOS ? bottomPadding : 10, top: isIOS ? 10 : 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCategoryWidgets(
                      context, MoviesCategories.Popular, moviesLists[0]),
                  _buildCategoryWidgets(
                      context, MoviesCategories.InTheatres, moviesLists[1]),
                  _buildCategoryWidgets(
                      context, MoviesCategories.Trending, moviesLists[2]),
                  _buildTopRatedMovies(
                      context, MoviesCategories.TopRated, moviesLists[3]),
                  _buildCategoryWidgets(
                      context, MoviesCategories.Upcoming, moviesLists[4])
                ],
              ),
            );
          } else if (moviesState is MoviesLoadingError) {
            return InternetConnectionErrorWidget(
              onPressed: _initializeMovies,
            );
          }

          return LoadingWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                largeTitle: Text(tabName[TabItem.movies]),
              ),
              SliverFillRemaining(
                  hasScrollBody: false, child: _buildMoviesWidget)
            ],
          ))
        : Scaffold(
            appBar: AppBar(
              title: Text(tabName[TabItem.movies]),
            ),
            body: _buildMoviesWidget);
  }
}

class _MoviesItemConfiguration {
  final MoviesCategories category;
  double listViewHeight;
  double imageHeight;
  double listItemWidth;
  String imageUrl = IMAGE_BASE_URL;

  _MoviesItemConfiguration({@required this.category})
      : assert(category != null) {
    _initializeAllValues(category);
  }

  _initializeAllValues(MoviesCategories category) {
    if (category == MoviesCategories.Popular) {
      listViewHeight = 220;
      imageHeight = 150;
      listItemWidth = 107;
      imageUrl += PosterSizes.w185;
    } else if (category == MoviesCategories.InTheatres) {
      listViewHeight = 170;
      imageHeight = 122;
      listItemWidth = 209;
      imageUrl += BackDropSizes.w300;
    } else if (category == MoviesCategories.TopRated) {
      listViewHeight = 240;
      imageHeight = 180;
      listItemWidth = 120;
      imageUrl += PosterSizes.w92;
    } else {
      listViewHeight = 200;
      imageHeight = 139;
      listItemWidth = 99;
      imageUrl += PosterSizes.w185;
    }
  }
}
