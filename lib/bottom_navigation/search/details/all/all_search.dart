import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/models/movies_list.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/movie_tv_show_app.dart';
import 'package:tmdb/utils/utils.dart';

class AllSearch extends StatefulWidget {
  final MoviesList moviesList;
  final TvShowsList tvShowsList;
  final CelebritiesList celebritiesList;
  final Function(TabItem) onClickSeeAll;

  AllSearch(
      {
      @required this.moviesList,
      @required this.tvShowsList,
      @required this.celebritiesList,
      @required this.onClickSeeAll});

  @override
  _AllSearchState createState() => _AllSearchState();
}

class _AllSearchState extends State<AllSearch>
    with AutomaticKeepAliveClientMixin<AllSearch> {
  void _navigateToCelebritiesDetails(
      BuildContext context, CelebritiesData celeb) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: celeb.id,
                      celebName: celeb.name,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: celeb.id,
                      celebName: celeb.name,
                      previousPageTitle: 'Back',
                    )));
  }

  Widget _buildCelebritiesWidget(List<CelebritiesData> celebs) {
    final double listViewHeight = 200;
    final double imageHeight = 130;
    final double listItemWidth = 100;

    return Column(
      children: <Widget>[
        _buildTextRow(TabItem.celebs),
        Container(
          height: listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: celebs.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 20,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _navigateToCelebritiesDetails(context, celebs[index]);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
                  width: listItemWidth,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: imageHeight,
                          width: listItemWidth,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: celebs[index].profilePath != null
                                ? Image.network(
                                    IMAGE_BASE_URL +
                                        ProfileSizes.w185 +
                                        celebs[index].profilePath,
                                    fit: BoxFit.fitWidth)
                                : Icon(
                                    CupertinoIcons.person_solid,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            celebs[index].name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            celebs[index].knownFor,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: 12),
                            textAlign: TextAlign.left,
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

  void _navigateToTvShowDetails(BuildContext context, TvShowsData tvShow) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: tvShow.id,
                      tvShowTitle: tvShow.name,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: tvShow.id,
                      tvShowTitle: tvShow.name,
                      previousPageTitle: 'Back',
                    )));
  }

  Widget _buildTvShowsWidget(List<TvShowsData> tvShows) {
    int font = 15;

    double listViewHeight = 170;
    double imageHeight = 122;
    double listItemWidth = 209;

    return Column(
      children: <Widget>[
        _buildTextRow(TabItem.tvShows),
        Container(
          height: listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: tvShows.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 8,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  _navigateToTvShowDetails(context, tvShows[index]);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 12),
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
                                  BackDropSizes.w300 +
                                  tvShows[index].backdropPath,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              tvShows[index].name,
                              maxLines: 1,
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
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              getTvShowsGenres(tvShows[index].genreIds),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 12),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        _divider(const EdgeInsets.only(left: 12, top: 12.0))
      ],
    );
  }

  void _navigateToMovieDetails(BuildContext context, MoviesData movie) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => MovieDetails(
                      id: movie.id,
                      movieTitle: movie.title,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => MovieDetails(
                      id: movie.id,
                      movieTitle: movie.title,
                      previousPageTitle: 'Back',
                    )));
  }

  Widget _buildTextRow(TabItem tabItem) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            tabName[tabItem],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              widget.onClickSeeAll(tabItem);
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

  Widget _buildMoviesWidget(MoviesList moviesList) {
    List<MoviesData> movies = moviesList.movies;

    double listViewHeight = 220;
    double imageHeight = 150;
    double listItemWidth = 107;
    int font = 13;

    return Column(
      children: <Widget>[
        _buildTextRow(TabItem.movies),
        Container(
          height: listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 8,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(left: 12),
                width: listItemWidth,
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _navigateToMovieDetails(context, movies[index]);
                      },
                      child: Container(
                          height: imageHeight,
                          width: listItemWidth,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3, color: Colors.grey),
                          ),
                          child: Image.network(
                              IMAGE_BASE_URL +
                                  PosterSizes.w185 +
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
                                fontSize: 11),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        _divider(const EdgeInsets.only(left: 12, top: 5.0))
      ],
    );
  }

  Widget _divider(EdgeInsets margin) {
    return Container(
      margin: margin,
      height: isIOS ? 0.8 : 0,
      color: Colors.grey[900],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMoviesWidget(widget.moviesList),
          _buildTvShowsWidget(widget.tvShowsList.tvShows),
          _buildCelebritiesWidget(widget.celebritiesList.celebrities)
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
