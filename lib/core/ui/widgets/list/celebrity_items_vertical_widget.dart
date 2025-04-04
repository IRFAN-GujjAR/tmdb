import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/list/celebrity_item_vertical_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_item_vertical_params.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_items_vertical_params.dart';

import '../../screen_utils.dart';
import '../divider_widget.dart';

class CelebrityItemsVerticalWidget extends StatelessWidget {
  final CelebrityItemsVerticalParams _params;

  const CelebrityItemsVerticalWidget(this._params, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        left: PagePadding.leftPadding,
        top: PagePadding.topPadding,
        bottom: PagePadding.bottomPadding,
      ),
      controller: _params.scrollController,
      itemBuilder: (context, index) {
        return CelebrityItemVerticalWidget(
          CelebrityItemVerticalParams.fromCelebsParams(_params, index),
        );
      },
      separatorBuilder: (context, index) {
        return DividerWidget(height: 20, indent: 0);
      },
      itemCount: _params.celebsIds.length,
    );
  }
}
