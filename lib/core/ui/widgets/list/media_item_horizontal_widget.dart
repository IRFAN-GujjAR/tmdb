import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_item_horizontal_param.dart';
import 'package:tmdb/core/urls/urls.dart';

import '../../../../features/main/movies/sub_features/details/presentation/pages/extra/movie_details_page_extra.dart';
import '../../../../features/main/tv_shows/sub_features/details/presentation/pages/extra/tv_show_details_page_extra.dart';
import '../../../router/routes/app_router_paths.dart';
import '../../initialize_app.dart';

class MediaItemHorizontalWidget extends StatelessWidget {
  final MediaItemHorizontalParams params;

  const MediaItemHorizontalWidget({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    String? imageUrl =
        params.isLandscape ? params.backdropPath : params.posterPath;
    if (imageUrl != null) {
      imageUrl =
          params.isLandscape
              ? URLS.backdropImageUrl(
                imageUrl: imageUrl,
                size: params.config.backdropSize,
              )
              : URLS.posterImageUrl(
                imageUrl: imageUrl,
                size: params.config.posterSize,
              );
    }
    return Container(
      width: params.config.listItemWidth,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (params.mediaType.isMovie)
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
              else
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
            },
            child: CustomNetworkImageWidget(
              type: params.mediaType.imageType,
              imageUrl: imageUrl,
              width: params.config.listItemWidth,
              height: params.config.imageHeight,
              fit: BoxFit.fill,
              borderRadius: 0,
              placeHolderSize: params.isLandscape ? 84 : 72,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Text(
                  params.mediaTitle,
                  maxLines: params.isLandscape ? 1 : 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: params.config.font,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          params.mediaGenre.isNotEmpty
              ? Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1.0),
                    child: Text(
                      params.mediaType.isMovie
                          ? getMovieGenres(params.mediaGenre)!
                          : getTvShowsGenres(params.mediaGenre)!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: params.isLandscape ? 12 : 11,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              )
              : Container(),
        ],
      ),
    );
  }
}
