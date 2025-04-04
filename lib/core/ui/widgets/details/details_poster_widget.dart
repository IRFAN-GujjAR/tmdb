import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';

import '../../utils.dart';

class DetailsPosterWidget extends StatelessWidget {
  final MediaType mediaType;
  final String? posterDetailsPath;
  final String? posterPath;

  const DetailsPosterWidget({
    super.key,
    required this.mediaType,
    required this.posterDetailsPath,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    String? imagePath = posterDetailsPath;
    if (imagePath == null) {
      imagePath = posterPath;
    }

    return Padding(
      padding: EdgeInsets.only(left: 5, top: 202),
      child: CustomNetworkImageWidget(
        type: mediaType.imageType,
        imageUrl:
            imagePath != null
                ? URLS.posterImageUrl(
                  imageUrl: imagePath,
                  size: PosterSizes.w185,
                )
                : null,
        width: 92,
        height: 136,
        fit: BoxFit.fitWidth,
        borderRadius: 0,
        movieTvBorderDecoration: false,
        placeHolderSize: 60,
      ),
      // child: Container(
      //   width: 92,
      //   height: 136,
      //   child:
      //       posterDetailsPath == null && posterPath == null
      //           ? mediaType == MediaType.Movie
      //               ? MoviePosterPlaceHolderWidget(size: 60)
      //               : TvPosterPlaceholderWidget(size: 60)
      //           : Image.network(
      //             IMAGE_BASE_URL +
      //                 PosterSizes.w185 +
      //                 (posterDetailsPath == null
      //                     ? posterPath!
      //                     : posterDetailsPath!),
      //             fit: BoxFit.fitWidth,
      //           ),
      // ),
    );
    // return Padding(
    //   padding: EdgeInsets.only(left: 5, top: 202),
    //   child: Container(
    //     width: 92,
    //     height: 136,
    //     child:
    //         posterDetailsPath == null && posterPath == null
    //             ? mediaType == MediaType.Movie
    //                 ? MoviePosterPlaceHolderWidget(size: 60)
    //                 : TvPosterPlaceholderWidget(size: 60)
    //             : Image.network(
    //               IMAGE_BASE_URL +
    //                   PosterSizes.w185 +
    //                   (posterDetailsPath == null
    //                       ? posterPath!
    //                       : posterDetailsPath!),
    //               fit: BoxFit.fitWidth,
    //             ),
    //   ),
    // );
  }
}
