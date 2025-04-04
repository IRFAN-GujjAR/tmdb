import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/core/ui/widgets/refresh_indicator_widget.dart';
import 'package:tmdb/features/main/tv_shows/domain/entities/tv_shows_entity.dart';

import '../../../../../core/ui/utils.dart';
import '../../../../../core/ui/widgets/custom_error_widget.dart';
import '../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../core/ui/widgets/tv_shows_category_widget.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../blocs/tv_shows_bloc.dart';

class TvShowsPage extends StatelessWidget {
  const TvShowsPage({super.key});

  Widget _bodyWidget(BuildContext context, TvShowsEntity tvShows) {
    return RefreshIndicatorWidget(
      onRefresh: (completer) {
        context.read<TvShowsBloc>().add(TvShowsEventRefresh(completer));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: PagePadding.topPadding,
          bottom: PagePadding.bottomPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TvShowsCategoryWidget(
              category: TvShowsCategories.AiringToday,
              tvShowsList: tvShows.airingToday,
            ),
            TvShowsCategoryWidget(
              category: TvShowsCategories.Trending,
              tvShowsList: tvShows.trending,
            ),
            TvShowsCategoryWidget(
              category: TvShowsCategories.TopRated,
              tvShowsList: tvShows.topRated,
            ),
            TvShowsCategoryWidget(
              category: TvShowsCategories.Popular,
              tvShowsList: tvShows.popular,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildTvShows {
    return BlocConsumer<TvShowsBloc, TvShowsState>(
      listener: (context, state) {
        if (state is TvShowsStateErrorWithCache) {
          UIUtl.showSnackBar(context, msg: state.error.error.errorMessage);
        }
      },
      builder: (context, state) {
        switch (state) {
          case TvShowsStateLoading():
            return LoadingWidget();
          case TvShowsStateLoaded():
            return _bodyWidget(context, state.tvShows);
          case TvShowsStateErrorWithCache():
            return _bodyWidget(context, state.tvShows);
          case TvShowsStateErrorWithoutCache():
            return CustomErrorWidget(
              error: state.error,
              onPressed: () {
                context.read<TvShowsBloc>().add(TvShowsEventLoad());
              },
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tabName[TabItem.tvShows]!)),
      body: SafeArea(child: _buildTvShows),
    );
  }
}
