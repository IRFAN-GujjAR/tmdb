import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_item_params.dart';
import 'package:tmdb/core/ui/widgets/list/params/celebrity_items_params.dart';

import 'celebrity_item_horizontal_widget.dart';

class CelebrityItemsHorizontalWidget extends StatelessWidget {
  final CelebrityItemsParams _params;

  const CelebrityItemsHorizontalWidget(this._params, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _params.config.listViewHeight,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: _params.celebsIds.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(width: 20);
        },
        itemBuilder: (BuildContext context, int index) {
          return CelebrityItemHorizontalWidget(
            CelebrityItemParams.fromListParams(_params, index),
          );
        },
      ),
    );
  }
}
