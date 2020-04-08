import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:http/http.dart' as http;

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
  List<MoviesData> _movies;
  int totalPages;
  int pageNumber;
  bool moviesItemLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _movies = widget.moviesList.movies;
    pageNumber = widget.moviesList.pageNumber;
    totalPages = widget.moviesList.totalPages;

    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        if (moviesItemLoading == false) {
          _getMovies();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _getMovies() async {
    moviesItemLoading = true;
    pageNumber++;
    MoviesList moviesList = await getCategoryMovies(http.Client(),
        widget.movieId, widget.category, pageNumber);
    setState(() {
      if (moviesList != null &&
          moviesList.movies != null &&
          moviesList.movies.isNotEmpty) {
        _movies.addAll(moviesList.movies);
      }
      moviesItemLoading = false;
    });
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

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: isIOS
            ? EdgeInsets.only(top: topPadding, left: 10, bottom: bottomPadding)
            : const EdgeInsets.only(top: 20, left: 10, bottom: 20),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToMovieDetails(
                  _movies[index].id, _movies[index].title, widget.category);
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
                          IMAGE_BASE_URL +
                              PosterSizes.w92 +
                              _movies[index].posterPath,
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
                            _movies[index].title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8),
                          child: Text(
                            getMovieGenres(_movies[index].genreIds),
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
                          child: buildRatingWidget(_movies[index].voteAverage,
                              _movies[index].voteCount),
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
        itemCount: _movies.length);
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
