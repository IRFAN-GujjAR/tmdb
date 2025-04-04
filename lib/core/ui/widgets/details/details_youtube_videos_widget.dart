import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/assets/custom_icons.dart';
import 'package:tmdb/core/entities/common/videos/video_entity.dart';

import '../../../urls/url_launcher_utils.dart';
import '../../utils.dart';
import '../text_row_widget.dart';
import 'details_divider_widget.dart';

class YoutubeVideosWidget extends StatelessWidget {
  final List<VideoEntity> videos;

  const YoutubeVideosWidget({super.key, required this.videos});

  Widget get _divider {
    return DetailsDividerWidget(topPadding: 10.0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        TextRowWidget(
          categoryName: 'Videos',
          showSeeAllBtn: false,
          onPressed: () {},
        ),
        Container(
          height: 90,
          child: ListView.separated(
            padding: const EdgeInsets.only(right: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  UrlLauncherUtils.launchYoutube(videos[index].key);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  height: 90,
                  width: 160,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Stack(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: getThumbnail(videoId: videos[index].key),
                        fit: BoxFit.fill,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 31,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.transparent, Colors.black],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.9],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 3,
                          ),
                          margin: const EdgeInsets.only(right: 6.0, bottom: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(3)),
                          ),
                          child: Image.asset(
                            CustomIcons.youtube,
                            height: 15,
                            width: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemCount: videos.length,
          ),
        ),
      ],
    );
  }
}
