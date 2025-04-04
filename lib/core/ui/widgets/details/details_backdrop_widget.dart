import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';

import '../../utils.dart';

class DetailsBackdropWidget extends StatelessWidget {
  final MediaType mediaType;
  final String? backdropDetailsPath;
  final String? backdropPath;

  const DetailsBackdropWidget({
    super.key,
    required this.mediaType,
    required this.backdropDetailsPath,
    required this.backdropPath,
  });

  @override
  Widget build(BuildContext context) {
    String? imageUrl = backdropDetailsPath ?? backdropPath;
    if (imageUrl != null) {
      imageUrl = URLS.backdropImageUrl(
        imageUrl: imageUrl,
        size: BackdropSizes.w780,
      );
    }

    return CustomNetworkImageWidget(
      type: mediaType.imageType,
      imageUrl: imageUrl,
      width: double.maxFinite,
      height: 211,
      fit: BoxFit.fitWidth,
      borderRadius: 0,
      placeHolderSize: 84,
      movieTvBorderDecoration: false,
    );

    // return Container(
    //     width: double.infinity,
    //     height: 211,
    //     child: backdropDetailsPath == null && backdropPath == null
    //         ? mediaType == MediaType.Movie
    //             ? MovieBackdropPlaceHolderWidget(
    //                 size: 84,
    //               )
    //             : TvBackdropPlaceHolderWidget(size: 84)
    //         : CachedNetworkImage(imageUrl:
    //         URLS.backdropImageUrl(imageUrl: ba, size: size)
    //             IMAGE_BASE_URL +
    //                 BackDropSizes.w780 +
    //                 (backdropDetailsPath == null
    //                     ? backdropPath!
    //                     : backdropDetailsPath!),
    //             fit: BoxFit.fitWidth,
    //           ));
  }
}
