import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/list/media_item_vertical_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_item_vertical_params.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_vertical_params.dart';

import '../../screen_utils.dart';
import '../divider_widget.dart';

final class MediaItemsVerticalWidget extends StatelessWidget {
  final MediaItemsVerticalParams params;

  const MediaItemsVerticalWidget({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        left: PagePadding.leftPadding,
        top: PagePadding.topPadding,
        bottom: PagePadding.bottomPadding,
      ),
      controller: params.scrollController,
      itemBuilder: (context, index) {
        return MediaItemVerticalWidget(
          params: MediaItemVerticalParams.fromListParams(params, index),
        );
      },
      separatorBuilder: (context, index) {
        return DividerWidget(indent: 0, height: 20);
      },
      itemCount: params.mediaIds.length,
    );
  }
}
