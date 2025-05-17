import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';
import 'package:tmdb/core/ui/widgets/list/media_items_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';
import 'package:tmdb/core/ui/widgets/text_row_widget.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/pages/extra/movie_details_page_extra.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/function_params/movies_list_cf_params.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/data/function_params/movies_list_cf_params_data.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/pages/extra/see_all_movies_page_extra.dart';

import '../../entities/movie/movie_entity.dart';
import '../../urls/urls.dart';
import '../screen_utils.dart';
import 'list/params/config/media_items_horizontal_config.dart';

class MoviesCategoriesWidget extends StatelessWidget {
  final MoviesCategories category;
  final MoviesListEntity moviesList;
  final int? movieId;

  MoviesCategoriesWidget({
    required this.category,
    required this.moviesList,
    this.movieId,
  });

  void _navigateToSeeAllMovies(BuildContext context) {
    if ((category == MoviesCategories.DetailsRecommended ||
            category == MoviesCategories.DetailsSimilar) &&
        movieId == null) {
      throw ('Movie Id cannot be null');
    }
    appRouterConfig.push(
      context,
      location: AppRouterPaths.SEE_ALL_MOVIES,
      extra: SeeAllMoviesPageExtra(
        pageTitle: movieCategoryName[category]!,
        moviesList: moviesList,
        cfParams:
            MoviesListCFParams(
              category: MoviesCFCategory.list,
              data: MoviesListCFParamsData(
                listCategory: category.cfCategory,
                pageNo: 1,
                movieId: movieId,
              ),
            ).toJson(),
      ),
    );
  }

  Widget _divider(MoviesCategories category) {
    return DividerWidget(topPadding: getDividerMargin(category));
  }

  double getDividerMargin(MoviesCategories category) {
    double topPadding = 0.0;
    switch (category) {
      case MoviesCategories.Popular:
        topPadding = 5.0;
        break;
      case MoviesCategories.InTheatres:
      case MoviesCategories.DetailsRecommended:
        topPadding = 12.0;
        break;
      case MoviesCategories.Trending:
      case MoviesCategories.DetailsSimilar:
        topPadding = 10.0;
        break;
      default:
        topPadding = 20.0;
        break;
    }
    return topPadding;
  }

  Widget _buildTextRow(BuildContext context) {
    return TextRowWidget(
      categoryName: movieCategoryName[category]!,
      showSeeAllBtn: true,
      onPressed: () {
        _navigateToSeeAllMovies(context);
      },
    );
  }

  Widget _buildTopRatedItems(BuildContext context, MovieEntity movie) {
    return GestureDetector(
      onTap: () {
        appRouterConfig.push(
          context,
          location: AppRouterPaths.MOVIE_DETAILS,
          extra: MovieDetailsPageExtra(
            id: movie.id,
            movieTitle: movie.title,
            posterPath: movie.posterPath,
            backdropPath: movie.backdropPath,
          ),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 0, style: BorderStyle.none),
        ),
        child: Row(
          children: <Widget>[
            CustomNetworkImageWidget(
              type: MediaImageType.Movie,
              imageUrl:
                  movie.posterPath == null
                      ? null
                      : URLS.posterImageUrl(
                        imageUrl: movie.posterPath!,
                        size: PosterSizes.w92,
                      ),
              width: 40,
              height: 40,
              fit: BoxFit.fitWidth,
              borderRadius: 0,
              placeHolderSize: 24,
            ),
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
                movie.genreIds.isNotEmpty
                    ? Container(
                      width: 190,
                      margin: const EdgeInsets.only(left: 8.0, top: 4),
                      child: Text(
                        getMovieGenres(movie.genreIds)!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                    : Container(),
              ],
            ),
            Spacer(),
            Icon(CupertinoIcons.forward, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _getTopRatedItems(
    BuildContext context,
    int mainIndex,
    int itemIndex,
    List<MovieEntity>? firstPairMovies,
    List<MovieEntity>? secondPairMovies,
    List<MovieEntity>? thirdPairMovies,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTopRatedItems(context, firstPairMovies![itemIndex]);
      case 1:
        return _buildTopRatedItems(context, secondPairMovies![itemIndex]);
      case 2:
        return _buildTopRatedItems(context, thirdPairMovies![itemIndex]);
    }

    return Container();
  }

  Widget _buildTopRateMoviesWidget(BuildContext context) {
    List<MovieEntity> movies = moviesList.movies;

    List<MovieEntity>? firstPairMovies;
    List<MovieEntity>? secondPairMovies;
    List<MovieEntity>? thirdPairMovies;

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
        TextRowWidget(
          categoryName: movieCategoryName[MoviesCategories.TopRated]!,
          showSeeAllBtn: true,
          onPressed: () => _navigateToSeeAllMovies(context),
        ),
        Container(
          height: 200,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int mainIndex) {
              return Container(
                margin: EdgeInsets.only(left: PagePadding.leftPadding),
                width: 310,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      0,
                      firstPairMovies,
                      secondPairMovies,
                      thirdPairMovies,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      1,
                      firstPairMovies,
                      secondPairMovies,
                      thirdPairMovies,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      2,
                      firstPairMovies,
                      secondPairMovies,
                      thirdPairMovies,
                    ),
                    _getTopRatedItems(
                      context,
                      mainIndex,
                      3,
                      firstPairMovies,
                      secondPairMovies,
                      thirdPairMovies,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(width: 8);
            },
            itemCount: 3,
          ),
        ),
        _divider(category),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (category == MoviesCategories.TopRated)
      return _buildTopRateMoviesWidget(context);

    _MoviesItemConfiguration moviesItemConfiguration = _MoviesItemConfiguration(
      category: category,
    );
    final movies = moviesList.movies;

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
        if (category == MoviesCategories.DetailsSimilar ||
            category == MoviesCategories.DetailsRecommended)
          _divider(category),
        _buildTextRow(context),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromMovies(
            movies: movies,
            previousPageTitle: 'Movies',
            isLandscape: category == MoviesCategories.InTheatres,
            config: MediaItemsHorizontalConfig(
              listViewHeight: moviesItemConfiguration.listViewHeight,
              listItemWidth: moviesItemConfiguration.listItemWidth,
              imageHeight: moviesItemConfiguration.imageHeight,
              font: font.toDouble(),
              posterSize: moviesItemConfiguration.posterSize,
              backdropSize: moviesItemConfiguration.backdropSize,
            ),
          ),
        ),
        if (category == MoviesCategories.Popular ||
            category == MoviesCategories.Upcoming ||
            category == MoviesCategories.DetailsRecommended ||
            category == MoviesCategories.DetailsSimilar)
          Container()
        else
          _divider(category),
      ],
    );
  }
}

class _MoviesItemConfiguration {
  final MoviesCategories category;
  late double listViewHeight;
  late double imageHeight;
  late double listItemWidth;
  PosterSizes posterSize = PosterSizes.w185;
  BackdropSizes backdropSize = BackdropSizes.w300;

  _MoviesItemConfiguration({required this.category}) {
    _initializeAllValues(category);
  }

  _initializeAllValues(MoviesCategories category) {
    switch (category) {
      case MoviesCategories.Popular:
        listViewHeight = 220;
        imageHeight = 150;
        listItemWidth = 107;
        posterSize = PosterSizes.w185;
        break;
      case MoviesCategories.InTheatres:
        listViewHeight = 170;
        imageHeight = 122;
        listItemWidth = 209;
        backdropSize = BackdropSizes.w300;
        break;
      case MoviesCategories.TopRated:
        listViewHeight = 240;
        imageHeight = 180;
        listItemWidth = 120;
        posterSize = PosterSizes.w92;
        break;
      case MoviesCategories.DetailsRecommended:
      case MoviesCategories.DetailsSimilar:
        listViewHeight = 205;
        imageHeight = 139;
        listItemWidth = 99;
        posterSize = PosterSizes.w185;
        break;
      case MoviesCategories.Trending:
      case MoviesCategories.Upcoming:
        listViewHeight = 200;
        imageHeight = 139;
        listItemWidth = 99;
        posterSize = PosterSizes.w185;
        break;
    }
  }
}
