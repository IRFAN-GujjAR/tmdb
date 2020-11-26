import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/see_all/see_all_tv_shows_states.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/tv_shows/see_all/see_all_tv_shows_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

import '../../../../../main.dart';

class WatchListTvShows extends StatefulWidget {
  final TvShowsList tvShowsList;

  WatchListTvShows({@required this.tvShowsList});

  @override
  _WatchListTvShowsState createState() => _WatchListTvShowsState();
}

class _WatchListTvShowsState extends State<WatchListTvShows>
    with AutomaticKeepAliveClientMixin<WatchListTvShows> {
  SeeAllTvShowsBloc _seeAllTvShowsBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    _seeAllTvShowsBloc = SeeAllTvShowsBloc(
        seeAllTvShowsRepo: SeeAllTvShowsRepo(client: getHttpClient(context)),
        tvShowsList: widget.tvShowsList);
    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllTvShowsBloc.state is SeeAllTvShowsLoadingMore)) {
        _getFavouriteTvShows();
      }
    });
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
    _seeAllTvShowsBloc.close();
    _scrollControllerUtil.dispose();
    super.dispose();
  }

  void _getFavouriteTvShows() {
    final tvShowsList = _seeAllTvShowsBloc.tvShowsList;
    if (tvShowsList.pageNumber < tvShowsList.totalPages) {
      final pageNumber = tvShowsList.pageNumber + 1;
      final user = Provider.of<LoginInfoProvider>(context, listen: false).user;
      _seeAllTvShowsBloc.add(LoadMoreSeeAllTvShows(
          previousTvShows: tvShowsList,
          url: URLS.watchListTvShows(user, pageNumber)));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return BlocBuilder<SeeAllTvShowsBloc, SeeAllTvShowsState>(
        cubit: _seeAllTvShowsBloc,
        builder: (context, state) {
          final tvShows = _seeAllTvShowsBloc.tvShowsList.tvShows;
          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                  left: 10, top: 20, bottom: isIOS ? bottomPadding : 20),
              controller: _scrollControllerUtil.scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils.navigate(
                        context: context,
                        page: TvShowDetails(
                            id: tvShows[index].id,
                            tvShowTitle: tvShows[index].name,
                            previousPageTitle: 'Back'));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.none)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 85,
                            width: 63,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: Image.network(
                                IMAGE_BASE_URL +
                                    PosterSizes.w92 +
                                    tvShows[index].posterPath,
                                fit: BoxFit.fill)),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  tvShows[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 2.0, left: 8),
                                child: Text(
                                  getTvShowsGenres(tvShows[index].genreIds),
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25.0, left: 5),
                                child: buildRatingWidget(
                                    tvShows[index].voteAverage,
                                    tvShows[index].voteCount),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0, right: 10),
                          child: Icon(
                            CupertinoIcons.forward,
                            color: Colors.grey,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 20,
                  thickness: 0.2,
                  color: Colors.grey,
                );
              },
              itemCount: tvShows.length);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
