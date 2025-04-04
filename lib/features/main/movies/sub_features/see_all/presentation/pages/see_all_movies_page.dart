import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/providers/see_all_movies_provider.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/presentation/widgets/see_all_movies_widget.dart';

class SeeAllMoviesPage extends StatelessWidget {
  const SeeAllMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<SeeAllMoviesProvider>().pageTitle),
      ),
      body: SafeArea(child: const SeeAllMoviesWidget()),
    );
  }
}
