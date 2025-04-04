import 'package:flutter/material.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/pages/extra/see_all_celebs_page_extra.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/widgets/see_all_celebs_widget.dart';

class SeeAllCelebsPage extends StatelessWidget {
  final SeeAllCelebsPageExtra _extra;

  const SeeAllCelebsPage(this._extra, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_extra.pageTitle)),
      body: CustomBodyWidget(child: const SeeAllCelebsWidget()),
    );
  }
}
