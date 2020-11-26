import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_bloc.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_events.dart';
import 'package:tmdb/bloc/home/movies/see_all/see_all_movies_states.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/movies/see_all/see_all_movies_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

import '../../../../../main.dart';

class RatedMovies extends StatefulWidget {
  final MoviesList moviesList;

  RatedMovies({@required this.moviesList});

  @override
  _RatedMoviesState createState() => _RatedMoviesState();
}

class _RatedMoviesState extends State<RatedMovies>
    with AutomaticKeepAliveClientMixin<RatedMovies> {
  SeeAllMoviesBloc _seeAllMoviesBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    _seeAllMoviesBloc = SeeAllMoviesBloc(
        seeAllMoviesRepo: SeeAllMoviesRepo(client: getHttpClient(context)),
        movies: widget.moviesList);
    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllMoviesBloc.state is SeeAllMoviesLoadingMore)) {
        _getRatedMovies();
      }
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _seeAllMoviesBloc.close();
    _scrollControllerUtil.dispose();
    super.dispose();
  }

  void _getRatedMovies() {
    final moviesList = _seeAllMoviesBloc.movies;
    if (moviesList.pageNumber < moviesList.totalPages) {
      final pageNumber = moviesList.pageNumber + 1;
      final user = Provider.of<LoginInfoProvider>(context, listen: false).user;
      _seeAllMoviesBloc.add(LoadMoreSeeAllMovies(
          previousMovies: moviesList, url: URLS.ratedMovies(user, pageNumber)));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return BlocBuilder<SeeAllMoviesBloc, SeeAllMoviesState>(
        cubit: _seeAllMoviesBloc,
        builder: (context, state) {
          final movies = _seeAllMoviesBloc.movies.movies;

          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  left: 10, top: 20, bottom: isIOS ? bottomPadding : 20),
              controller: _scrollControllerUtil.scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils.navigate(
                        context: context,
                        page: MovieDetails(
                            id: movies[index].id,
                            movieTitle: movies[index].title,
                            previousPageTitle: 'Back'));
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
  bool get wantKeepAlive => true;
}
