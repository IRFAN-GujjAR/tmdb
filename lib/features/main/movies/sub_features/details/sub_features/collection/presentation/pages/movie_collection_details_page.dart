import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';
import 'package:tmdb/core/ui/widgets/list/media_item_vertical_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_item_vertical_params.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/presentation/blocs/bloc/movie_collection_details_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/presentation/pages/extra/movie_collection_details_page_extra.dart';
import 'package:tmdb/main.dart';

import '../../../../../../../../../core/entities/movie/movie_entity.dart';
import '../../../../../../../../../core/ui/theme/colors/colors_utils.dart';
import '../../../../../../../../../core/ui/widgets/loading_widget.dart';

class MovieCollectionDetailsPage extends StatelessWidget {
  final MovieCollectionDetailsPageExtra _extra;

  const MovieCollectionDetailsPage(this._extra, {super.key});

  Widget get _divider {
    return DividerWidget(topPadding: 15.0, indent: 0);
  }

  Widget _buildCollectionItems(BuildContext context, List<MovieEntity> movies) {
    int counter = 0;

    List<Widget> items =
        movies.map((movie) {
          counter++;
          return Column(
            children: [
              if (counter != 1) DividerWidget(indent: 0, height: 20),
              MediaItemVerticalWidget(
                params: MediaItemVerticalParams(
                  mediaType: MediaType.Movie,
                  mediaId: movie.id,
                  mediaTitle: movie.title,
                  mediaGenre: movie.genreIds,
                  posterPath: movie.posterPath,
                  backdropPath: movie.backdropPath,
                  voteAverage: movie.voteAverage,
                  voteCount: movie.voteCount,
                ),
              ),
            ],
          );
          // return GestureDetector(
          //   onTap: () {
          //     NavigationUtils.navigate(
          //       context: context,
          //       page: MovieDetailsPage(
          //         id: movie.id,
          //         movieTitle: movie.title,
          //         previousPageTitle: widget.name,
          //         posterPath: movie.posterPath,
          //         backdropPath: movie.backdropPath,
          //       ),
          //     );
          //   },
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         margin: const EdgeInsets.only(top: 15),
          //         decoration: BoxDecoration(
          //           border: Border.all(width: 0, style: BorderStyle.none),
          //         ),
          //         child: Row(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             Expanded(
          //               flex: 2,
          //               child: Container(
          //                 height: 93,
          //                 width: 62,
          //                 decoration: BoxDecoration(
          //                   border: Border.all(width: 0.3, color: Colors.grey),
          //                 ),
          //                 child:
          //                     movie.posterPath == null
          //                         ? MoviePosterPlaceHolderWidget(size: 48)
          //                         : Image.network(
          //                           IMAGE_BASE_URL +
          //                               PosterSizes.w185 +
          //                               movie.posterPath!,
          //                           fit: BoxFit.fill,
          //                         ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 9,
          //               child: Padding(
          //                 padding: const EdgeInsets.only(
          //                   left: 8.0,
          //                   top: 3,
          //                   right: 20,
          //                 ),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: <Widget>[
          //                     Container(
          //                       width: 250,
          //                       child: Text(
          //                         counter.toString() + '. ' + movie.title,
          //                         style: TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                         maxLines: 1,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                     Container(
          //                       width: 240,
          //                       margin: const EdgeInsets.only(top: 3),
          //                       child: Text(
          //                         getMovieGenres(movie.genreIds)!,
          //                         style: TextStyle(
          //                           color: Colors.grey,
          //                           fontSize: 14,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                         maxLines: 1,
          //                         overflow: TextOverflow.ellipsis,
          //                       ),
          //                     ),
          //                     CustomRatingWidget(
          //                       voteAverage: movie.voteAverage,
          //                       voteCount: movie.voteCount,
          //                       margin: const EdgeInsets.only(top: 15),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Expanded(
          //               flex: 1,
          //               child: Padding(
          //                 padding: const EdgeInsets.only(right: 8.0, top: 25),
          //                 child: Icon(
          //                   CupertinoIcons.forward,
          //                   color: Colors.grey,
          //                   size: 18,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       counter != movies.length
          //           ? Container(
          //             margin: const EdgeInsets.only(top: 10),
          //             height: 0.5,
          //             color: Colors.grey[900],
          //           )
          //           : Container(),
          //     ],
          //   ),
          // );
        }).toList();

    items =
        [
          _divider,
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              'This Collection includes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ] +
        items;

    return Padding(
      padding: const EdgeInsets.only(left: PagePadding.leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget get _buildCollectionDetailsWidget {
    return BlocBuilder<MovieCollectionDetailsBloc, MovieCollectionDetailsState>(
      builder: (context, state) {
        switch (state) {
          case MovieCollectionDetailsStateInitial():
          case MovieCollectionDetailsStateLoading():
            return LoadingWidget();
          case MovieCollectionDetailsStateLoaded():
            final collectionDetails = state.movieCollectionDetails;

            String? posterImageUrl =
                collectionDetails.posterPath ?? _extra.posterPath;
            if (posterImageUrl != null) {
              posterImageUrl = URLS.posterImageUrl(
                imageUrl: posterImageUrl,
                size: PosterSizes.w185,
              );
            }

            String? backdropImageUrl =
                collectionDetails.backdropPath ?? _extra.backdropPath;
            if (backdropImageUrl != null) {
              backdropImageUrl = URLS.backdropImageUrl(
                imageUrl: backdropImageUrl,
                size: BackdropSizes.w780,
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: PagePadding.bottomPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      CustomNetworkImageWidget(
                        type: MediaImageType.Movie,
                        imageUrl: backdropImageUrl,
                        width: double.maxFinite,
                        height: 211,
                        fit: BoxFit.fitWidth,
                        borderRadius: 0,
                        placeHolderSize: 84,
                        movieTvBorderDecoration: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 65),
                        child: Container(
                          width: double.infinity,
                          height: 158,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                ColorUtils.scaffoldBackgroundColor(context),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.8],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              isIOS
                                  ? const EdgeInsets.only(right: 5, top: 140.0)
                                  : const EdgeInsets.only(right: 5, top: 155),
                          child: CustomNetworkImageWidget(
                            type: MediaImageType.Movie,
                            imageUrl: posterImageUrl,
                            width: 92,
                            height: 136,
                            fit: BoxFit.fitWidth,
                            borderRadius: 0,
                            placeHolderSize: 60,
                            movieTvBorderDecoration: false,
                          ),
                        ),
                      ),
                      Container(
                        width: 250,
                        margin:
                            isIOS
                                ? const EdgeInsets.only(left: 15, top: 140)
                                : const EdgeInsets.only(left: 15, top: 155),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              collectionDetails.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                collectionDetails.overview,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  _buildCollectionItems(context, collectionDetails.movies),
                ],
              ),
            );
          case MovieCollectionDetailsStateError():
            return CustomErrorWidget(
              error: state.error,
              onPressed: () {
                context.read<MovieCollectionDetailsBloc>().add(
                  MovieCollectionDetailsEventLoad(_extra.id),
                );
              },
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_extra.name)),
      body: CustomBodyWidget(child: _buildCollectionDetailsWidget),
    );
  }
}
