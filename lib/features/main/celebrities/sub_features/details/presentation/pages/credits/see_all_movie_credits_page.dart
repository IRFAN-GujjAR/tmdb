import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/ui/widgets/list/media_items_vertical_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_vertical_params.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/movie_credits_entity.dart';

import '../../../../../../../../core/entities/movie/movie_entity.dart';
import '../../providers/see_all_movie_credits_scroll_controller_provider.dart';

enum _MovieCredits { Cast, Crew }

class SeeAllMovieCreditsPage extends StatefulWidget {
  final MovieCreditsEntity movieCredits;

  SeeAllMovieCreditsPage({required this.movieCredits});

  @override
  _SeeAllMovieCreditsPageState createState() => _SeeAllMovieCreditsPageState();
}

class _SeeAllMovieCreditsPageState extends State<SeeAllMovieCreditsPage>
    with SingleTickerProviderStateMixin<SeeAllMovieCreditsPage> {
  late TabController _tabController;
  final _seeAllMovieCreditsScrollControllerProvider =
      SeeAllMovieCreditsScrollControllerProvider();

  @override
  void initState() {
    int length = 0;
    if (widget.movieCredits.cast.isNotEmpty &&
        widget.movieCredits.crew.isNotEmpty) {
      length = 2;
    } else {
      length = 1;
    }
    _tabController = TabController(
      initialIndex: 0,
      length: length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _seeAllMovieCreditsScrollControllerProvider.dispose();
    super.dispose();
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (widget.movieCredits.cast.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllMovieCreditsScrollControllerProvider,
          child: _AllMovies(
            type: _MovieCredits.Cast,
            movies: widget.movieCredits.cast,
          ),
        ),
      );
    }
    if (widget.movieCredits.crew.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllMovieCreditsScrollControllerProvider,
          child: _AllMovies(
            type: _MovieCredits.Crew,
            movies: widget.movieCredits.crew,
          ),
        ),
      );
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabController.length,
      child: Scaffold(
        body: NestedScrollView(
          controller:
              _seeAllMovieCreditsScrollControllerProvider
                  .parentScrollController,
          headerSliverBuilder: (context, _) {
            return [
              _tabController.length < 2
                  ? SliverAppBar(title: Text('Movies'), pinned: true)
                  : SliverAppBar(
                    title: Text('Movies'),
                    pinned: true,
                    floating: true,
                    snap: true,
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: <Tab>[Tab(text: 'Cast'), Tab(text: 'Crew')],
                    ),
                  ),
            ];
          },
          body: TabBarView(controller: _tabController, children: _buildPages),
        ),
      ),
    );
  }
}

class _AllMovies extends StatefulWidget {
  final _MovieCredits type;
  final List<MovieEntity> movies;

  _AllMovies({required this.type, required this.movies});

  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<_AllMovies>
    with AutomaticKeepAliveClientMixin<_AllMovies> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final provider = context.read<SeeAllMovieCreditsScrollControllerProvider>();
    return NotificationListener<ScrollNotification>(
      onNotification: provider.onScrollNotification,
      child: MediaItemsVerticalWidget(
        params: MediaItemsVerticalParams.fromMovies(
          widget.type == _MovieCredits.Cast
              ? provider.scrollController1
              : provider.scrollController2,
          widget.movies,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
