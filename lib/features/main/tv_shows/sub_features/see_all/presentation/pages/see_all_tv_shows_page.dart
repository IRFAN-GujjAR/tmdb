import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/presentation/providers/see_all_tv_shows_provider.dart';

import '../widgets/see_all_tv_shows_widget.dart';

class SeeAllTvShowsPage extends StatelessWidget {
  const SeeAllTvShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<SeeAllTvShowsProvider>().pageTitle),
      ),
      body: SafeArea(child: const SeeAllTvShowsWidget()),
    );
  }
}
