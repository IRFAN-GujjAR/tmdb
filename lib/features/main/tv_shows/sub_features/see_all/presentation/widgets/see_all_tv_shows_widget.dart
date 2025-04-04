import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/ui/widgets/list/media_items_vertical_widget.dart';
import '../../../../../../../core/ui/widgets/list/params/media_items_vertical_params.dart';
import '../providers/see_all_tv_shows_provider.dart';

class SeeAllTvShowsWidget extends StatelessWidget {
  const SeeAllTvShowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SeeAllTvShowsProvider>(
      builder: (context, provider, _) {
        return MediaItemsVerticalWidget(
          params: MediaItemsVerticalParams.fromTvShows(
            provider.scrollController,
            provider.tvShowsList.tvShows,
          ),
        );
      },
    );
  }
}
