import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_item_vertical_params.dart';
import 'package:tmdb/core/ui/widgets/rating_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/pages/extra/movie_details_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/presentation/pages/extra/tv_show_details_page_extra.dart';

class MediaItemVerticalWidget extends StatelessWidget {
  final MediaItemVerticalParams params;

  const MediaItemVerticalWidget({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (params.mediaType.isMovie) {
          appRouterConfig.push(
            context,
            location: AppRouterPaths.MOVIE_DETAILS,
            extra: MovieDetailsPageExtra(
              id: params.mediaId,
              movieTitle: params.mediaTitle,
              posterPath: params.posterPath,
              backdropPath: params.backdropPath,
            ),
          );
        } else {
          appRouterConfig.push(
            context,
            location: AppRouterPaths.TV_SHOW_DETAILS,
            extra: TvShowDetailsPageExtra(
              id: params.mediaId,
              tvShowTitle: params.mediaTitle,
              posterPath: params.posterPath,
              backdropPath: params.backdropPath,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0, style: BorderStyle.none),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomNetworkImageWidget(
              type: params.mediaType.imageType,
              imageUrl:
                  params.posterPath == null
                      ? null
                      : URLS.posterImageUrl(
                        imageUrl: params.posterPath!,
                        size: PosterSizes.w92,
                      ),
              width: 63,
              height: 85,
              fit: BoxFit.fill,
              borderRadius: 0,
              placeHolderSize: 60,
            ),
            Container(
              width: 250,
              padding: const EdgeInsets.only(top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      params.mediaTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0, left: 8),
                    child: Text(
                      getMovieGenres(params.mediaGenre)!,
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, left: 5),
                    child: CustomRatingWidget(
                      voteAverage: params.voteAverage,
                      voteCount: params.voteCount,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 10),
              child: Icon(CupertinoIcons.forward, color: Colors.grey, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
