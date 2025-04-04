import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/photo/extra/celebrity_photo_page_extra.dart';

class CelebrityPhotoPage extends StatelessWidget {
  final CelebrityPhotoPageExtra _extra;

  CelebrityPhotoPage(this._extra, {super.key});

  Widget _buildPlaceHolderWidget(
    BuildContext context, {
    required double progress,
  }) {
    return Stack(
      children: [
        Image.network(
          URLS.profileImageUrl(imageUrl: _extra.photo, size: ProfileSizes.w185),
          fit: BoxFit.contain,
          height: double.maxFinite,
          width: double.maxFinite,
          alignment: Alignment.center,
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              alignment: Alignment.center,
              child: CircularProgressIndicator(value: progress, strokeWidth: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          initialScale: PhotoViewComputedScale.contained,
          imageProvider: NetworkImage(
            URLS.profileImageUrl(
              imageUrl: _extra.photo,
              size: ProfileSizes.original,
            ),
          ),
          loadingBuilder: (context, imageChunk) {
            int expectedTotalBytes = 0;
            int loadedBytes = 0;
            if (imageChunk != null) {
              expectedTotalBytes = imageChunk.expectedTotalBytes ?? 0;
              loadedBytes = imageChunk.cumulativeBytesLoaded;
            }
            double value = (loadedBytes / expectedTotalBytes);
            if (value.isNaN) {
              value = 0.05;
            }

            return _buildPlaceHolderWidget(context, progress: value);
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 4),
          child: SafeArea(
            child: Material(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(100),
              color: ColorUtils.scaffoldBackgroundColor(
                context,
              ).withOpacity(0.5),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }
}
