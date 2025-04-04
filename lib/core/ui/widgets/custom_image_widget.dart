import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/movie_poster_placeholder_widget.dart';
import 'package:tmdb/core/ui/widgets/tv_poster_placeholder_widget.dart';

import 'celebrity_profile_placeholder_widget.dart';

class CustomNetworkImageWidget extends StatelessWidget {
  final MediaImageType type;
  final String? imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final double borderRadius;
  final bool movieTvBorderDecoration;
  final double placeHolderSize;
  final bool celebrityPlaceHolderCircularShape;

  const CustomNetworkImageWidget({
    super.key,
    required this.type,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.fit,
    required this.borderRadius,
    this.movieTvBorderDecoration = true,
    required this.placeHolderSize,
    this.celebrityPlaceHolderCircularShape = false,
  });

  Widget get _networkImageWidget {
    return CachedNetworkImage(imageUrl: imageUrl!, fit: fit);
  }

  Widget get _celebrityWidget {
    return imageUrl == null && celebrityPlaceHolderCircularShape
        ? Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(placeHolderSize),
          ),
          child: CelebrityProfilePlaceholderWidget(size: placeHolderSize),
        )
        : Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child:
              imageUrl == null
                  ? CelebrityProfilePlaceholderWidget(size: placeHolderSize)
                  : ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: _networkImageWidget,
                  ),
        );
  }

  Widget get _movieWidget {
    return Container(
      height: height,
      width: width,
      decoration:
          movieTvBorderDecoration
              ? BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
              )
              : null,
      child:
          imageUrl == null
              ? MoviePosterPlaceHolderWidget(size: placeHolderSize)
              : _networkImageWidget,
    );
  }

  Widget get _tvShowWidget {
    return Container(
      height: height,
      width: width,
      decoration:
          movieTvBorderDecoration
              ? BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.3),
              )
              : null,
      child:
          imageUrl == null
              ? TvPosterPlaceholderWidget(size: placeHolderSize)
              : _networkImageWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MediaImageType.Movie:
        return _movieWidget;
      case MediaImageType.TvShow:
        return _tvShowWidget;
      case MediaImageType.Celebrity:
        return _celebrityWidget;
    }
  }
}
