import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_bloc.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_events.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/movies/see_all/see_all_movies_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

import '../movies.dart';

class SeeAllMovies extends StatefulWidget {
  final String previousPageTitle;
  final MoviesCategories category;
  final MoviesList moviesList;
  final int movieId;

  SeeAllMovies(
      {@required this.previousPageTitle,
      @required this.category,
      @required this.moviesList,
      @required this.movieId});

  @override
  _SeeAllMoviesState createState() => _SeeAllMoviesState();
}

class _SeeAllMoviesState extends State<SeeAllMovies> {
  SeeAllMoviesBloc _seeAllMoviesBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    _seeAllMoviesBloc = SeeAllMoviesBloc(
        seeAllMoviesRepo: SeeAllMoviesRepo(client: getHttpClient(context)),
        movies: widget.moviesList);

    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllMoviesBloc.state is SeeAllMoviesLoadingMore)) {
        _getMovies();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerUtil.dispose();
    _seeAllMoviesBloc.close();
    super.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _getMovies() {
    String url = '';
    final movies = _seeAllMoviesBloc.movies;
    final pageNumber = movies.pageNumber + 1;
    if (movies.pageNumber < movies.totalPages) {
      switch (widget.category) {
        case MoviesCategories.Popular:
          url = URLS.popularMovies(pageNumber);
          break;
        case MoviesCategories.InTheatres:
          url = URLS.inTheatresMovies(pageNumber);
          break;
        case MoviesCategories.Trending:
          url = URLS.trendingMovies(pageNumber);
          break;
        case MoviesCategories.TopRated:
          url = URLS.topRatedMovies(pageNumber);
          break;
        case MoviesCategories.Upcoming:
          url = URLS.upComingMovies(pageNumber);
          break;
        case MoviesCategories.DetailsRecommended:
          url = URLS.recommendedMovies(widget.movieId, pageNumber);
          break;
        case MoviesCategories.DetailsSimilar:
          url = URLS.similarMovies(widget.movieId, pageNumber);
          break;
      }
      _seeAllMoviesBloc
          .add(LoadMoreSeeAllMovies(previousMovies: movies, url: url));
    }
  }

  void _navigateToMovieDetails(
      int id, String movieTitle, MoviesCategories category) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return MovieDetails(
                  id: id,
                  movieTitle: movieTitle,
                  previousPageTitle: movieCategoryName[category],
                );
              })
            : MaterialPageRoute(builder: (context) {
                return MovieDetails(
                  id: id,
                  movieTitle: movieTitle,
                  previousPageTitle: movieCategoryName[category],
                );
              }));
  }

  Widget get _buildSeeAllMoviesWidget {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double topPadding = padding.top + kToolbarHeight + 5;
    final double bottomPadding = padding.bottom + 30;

    return BlocBuilder<SeeAllMoviesBloc, SeeAllMoviesState>(
        cubit: _seeAllMoviesBloc,
        builder: (context, state) {
          MoviesList moviesList;
          if (state is SeeAllMoviesLoaded) {
            moviesList = state.movies;
          } else if (state is SeeAllMoviesLoadingMore) {
            moviesList = state.movies;
          } else if (state is SeeAllMoviesError) {
            moviesList = state.movies;
          }
          final movies = moviesList.movies;
          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: isIOS
                  ? EdgeInsets.only(
                      top: topPadding, left: 10, bottom: bottomPadding)
                  : const EdgeInsets.only(top: 20, left: 10, bottom: 20),
              controller: _scrollControllerUtil.scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToMovieDetails(
                        movies[index].id, movies[index].title, widget.category);
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
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Image.network(
                                IMAGE_BASE_URL +
                                    PosterSizes.w92 +
                                    movies[index].posterPath,
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
                                  movies[index].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, left: 8),
                                child: Text(
                                  getMovieGenres(movies[index].genreIds),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 5),
                                child: buildRatingWidget(
                                    movies[index].voteAverage,
                                    movies[index].voteCount),
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
              itemCount: movies.length);
        });
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
                  movieCategoryName[widget.category],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeeAllMoviesWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text(movieCategoryName[widget.category]),
            ),
            body: _buildSeeAllMoviesWidget,
          );
  }
}
