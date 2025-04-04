import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/list/media_item_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_item_horizontal_param.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';

class MediaItemsHorizontalWidget extends StatelessWidget {
  final MediaItemsHorizontalParams params;

  const MediaItemsHorizontalWidget({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: params.config.listViewHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: params.mediaIds.length < 20 ? params.mediaIds.length : 20,
        padding: const EdgeInsets.only(left: 12, right: 12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(width: 20);
        },
        itemBuilder: (BuildContext context, int index) {
          return MediaItemHorizontalWidget(
            params: MediaItemHorizontalParams.fromListParams(params, index),
          );
        },
      ),
    );
  }
}
