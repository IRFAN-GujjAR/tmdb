import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/search_api.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/utils/utils.dart';

class MoviesSearch extends StatefulWidget {
  final String searchQuery;
  final MoviesList moviesList;

  MoviesSearch(
      {
      @required this.moviesList,
      @required this.searchQuery});

  @override
  _MoviesSearchState createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch>
    with AutomaticKeepAliveClientMixin<MoviesSearch> {
  List<MoviesData> _movies;
  int _totalPages;
  int _pageNumber;
  bool _moviesItemLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _movies = widget.moviesList.movies;
    _totalPages = widget.moviesList.totalPages;
    _pageNumber = widget.moviesList.pageNumber;

    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        if (_moviesItemLoading == false) {
          if (_pageNumber < _totalPages) {
            _getSearchedMovies();
          }
        }
      }
    });
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
    _scrollController.dispose();
  }

  Future<void> _getSearchedMovies() async {
    _moviesItemLoading = true;
    _pageNumber++;
    MoviesList moviesList = await searchMovies(
        http.Client(), widget.searchQuery, _pageNumber);
    setState(() {
      _movies.addAll(moviesList.movies);
      _moviesItemLoading = false;
    });
  }


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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding=MediaQuery.of(context).padding.bottom+20;


    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, top: 20, bottom: isIOS?bottomPadding:20),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToMovieDetails(_movies[index].id, _movies[index].title);
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
  bool get wantKeepAlive => true;
}
