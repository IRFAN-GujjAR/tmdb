import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/ui/theme/colors/colors_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/loading_widget.dart';
import 'package:tmdb/core/ui/widgets/no_results_widget.dart';
import 'package:tmdb/features/main/search/details/domain/entities/search_details_entity.dart';
import 'package:tmdb/features/main/search/details/presentation/blocs/search_details_bloc.dart';
import 'package:tmdb/features/main/search/details/presentation/providers/search_details_provider.dart';
import 'package:tmdb/features/main/search/details/presentation/widgets/all_search_widget.dart';
import 'package:tmdb/features/main/search/details/presentation/widgets/movies_search_widget.dart';
import 'package:tmdb/features/main/search/search/presentation/providers/search_bar_provider.dart';

import '../widgets/celebrities_search_widget.dart';
import '../widgets/tv_shows_search_widget.dart';

class SearchDetailsPage extends StatefulWidget {
  const SearchDetailsPage({super.key});

  @override
  State<SearchDetailsPage> createState() => _SearchDetailsPageState();
}

class _SearchDetailsPageState extends State<SearchDetailsPage>
    with SingleTickerProviderStateMixin<SearchDetailsPage> {
  List<Widget> _buildPages(SearchDetailsEntity searchDetails) {
    List<Widget> pages = [];
    if (searchDetails.isAll) {
      pages = [
        AllSearchWidget(
          moviesList: searchDetails.moviesList,
          tvShowsList: searchDetails.tvShowsList,
          celebritiesList: searchDetails.celebritiesList,
        ),
        MoviesSearchWidget(moviesList: searchDetails.moviesList),
        TvShowsSearchWidget(tvShowsList: searchDetails.tvShowsList),
        CelebritiesSearchWidget(celebritiesList: searchDetails.celebritiesList),
      ];
      return pages;
    } else {
      if (searchDetails.isMovies)
        pages.add(MoviesSearchWidget(moviesList: searchDetails.moviesList));
      if (searchDetails.isTvShows)
        pages.add(TvShowsSearchWidget(tvShowsList: searchDetails.tvShowsList));
      if (searchDetails.isCelebrities)
        pages.add(
          CelebritiesSearchWidget(
            celebritiesList: searchDetails.celebritiesList,
          ),
        );
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SearchDetailsProvider>();
    return BlocListener<SearchDetailsBloc, SearchDetailsState>(
      listener: (context, state) {
        context.read<SearchBarProvider>().unFocus;
        provider.onSearchDetailsBlocStateChanged(state, this);
      },
      child: Consumer<SearchDetailsProvider>(
        builder: (context, provider, _) {
          final state = provider.state;
          switch (state) {
            case SearchDetailsStateInitial():
            case SearchDetailsStateLoading():
              return LoadingWidget();
            case SearchDetailsStateLoaded():
              return Container(
                child: Column(
                  children: <Widget>[
                    if (provider.tabController!.length > 1)
                      Container(
                        color: ColorUtils.appBarColor(context),
                        child: TabBar(
                          controller: provider.tabController,
                          tabs: <Tab>[
                            if (state.searchDetails.isAll) Tab(text: 'All'),
                            if (state.searchDetails.isMovies)
                              Tab(text: 'Movies'),
                            if (state.searchDetails.isTvShows)
                              Tab(text: 'Tv Shows'),
                            if (state.searchDetails.isCelebrities)
                              Tab(text: 'Celebs'),
                          ],
                        ),
                      ),
                    Expanded(
                      child: TabBarView(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: provider.tabController,
                        children: _buildPages(state.searchDetails),
                      ),
                    ),
                  ],
                ),
              );
            case SearchDetailsStateNoResultsFound():
              return NoResultsWidget();
            case SearchDetailsStateError():
              return CustomErrorWidget(error: state.error, onPressed: () {});
          }
        },
      ),
    );
  }
}
