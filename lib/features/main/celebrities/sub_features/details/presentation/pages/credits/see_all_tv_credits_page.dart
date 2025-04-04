import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/tv_show/tv_show_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/tv_show_credits_entity.dart';

import '../../../../../../../../core/ui/widgets/list/media_items_vertical_widget.dart';
import '../../../../../../../../core/ui/widgets/list/params/media_items_vertical_params.dart';
import '../../providers/see_all_tv_credits_scroll_controller_provider.dart';

enum _TvCredits { Cast, Crew }

class SeeAllTvCreditsPage extends StatefulWidget {
  final TvShowCreditsEntity tvCredits;

  SeeAllTvCreditsPage({required this.tvCredits});

  @override
  _SeeAllTvCreditsPageState createState() => _SeeAllTvCreditsPageState();
}

class _SeeAllTvCreditsPageState extends State<SeeAllTvCreditsPage>
    with SingleTickerProviderStateMixin<SeeAllTvCreditsPage> {
  late TabController _tabController;
  final _seeAllTvCreditsScrollControllerProvider =
      SeeAllTvCreditsScrollControllerProvider();

  @override
  void initState() {
    int length = 0;

    if (widget.tvCredits.cast.isNotEmpty && widget.tvCredits.crew.isNotEmpty) {
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
    _seeAllTvCreditsScrollControllerProvider.dispose();
    super.dispose();
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (widget.tvCredits.cast.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllTvCreditsScrollControllerProvider,
          child: _AllTvShows(
            type: _TvCredits.Cast,
            tvShows: widget.tvCredits.cast,
          ),
        ),
      );
    }
    if (widget.tvCredits.crew.isNotEmpty) {
      pages.add(
        ChangeNotifierProvider.value(
          value: _seeAllTvCreditsScrollControllerProvider,
          child: _AllTvShows(
            type: _TvCredits.Crew,
            tvShows: widget.tvCredits.crew,
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
              _seeAllTvCreditsScrollControllerProvider.parentScrollController,
          headerSliverBuilder: (context, _) {
            return [
              _tabController.length < 2
                  ? SliverAppBar(title: Text('Tv Shows'), pinned: true)
                  : SliverAppBar(
                    title: Text('Tv Shows'),
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

class _AllTvShows extends StatefulWidget {
  final _TvCredits type;
  final List<TvShowEntity> tvShows;

  _AllTvShows({required this.type, required this.tvShows});

  @override
  _AllTvShowsState createState() => _AllTvShowsState();
}

class _AllTvShowsState extends State<_AllTvShows>
    with AutomaticKeepAliveClientMixin<_AllTvShows> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final provider = context.read<SeeAllTvCreditsScrollControllerProvider>();
    return NotificationListener<ScrollNotification>(
      onNotification: provider.onScrollNotification,
      child: MediaItemsVerticalWidget(
        params: MediaItemsVerticalParams.fromTvShows(
          widget.type == _TvCredits.Cast
              ? provider.scrollController1
              : provider.scrollController2,
          widget.tvShows,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
