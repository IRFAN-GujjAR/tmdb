import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/ui/widgets/list/media_items_vertical_widget.dart';
import '../../../../../../../core/ui/widgets/list/params/media_items_vertical_params.dart';
import '../providers/see_all_movies_provider.dart';

class SeeAllMoviesWidget extends StatelessWidget {
  const SeeAllMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SeeAllMoviesProvider>(
      builder: (context, provider, _) {
        return MediaItemsVerticalWidget(
          params: MediaItemsVerticalParams.fromMovies(
            provider.scrollController,
            provider.moviesList.movies,
          ),
        );
      },
    );
  }
}
