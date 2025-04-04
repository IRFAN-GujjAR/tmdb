import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../core/ui/widgets/list/celebrity_items_vertical_widget.dart';
import '../../../../../../../core/ui/widgets/list/params/celebrity_items_vertical_params.dart';
import '../providers/see_all_celebs_provider.dart';

class SeeAllCelebsWidget extends StatelessWidget {
  const SeeAllCelebsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SeeAllCelebsProvider>(
      builder: (context, provider, _) {
        return CelebrityItemsVerticalWidget(
          CelebrityItemsVerticalParams.fromCelebs(
            provider.celebsList.celebrities,
            scrollController: provider.scrollController,
          ),
        );
      },
    );
  }
}
