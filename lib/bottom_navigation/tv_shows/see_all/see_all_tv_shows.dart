import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/utils/utils.dart';

import '../../../main.dart';
import '../tv_shows.dart';

class SeeAllTvShows extends StatefulWidget {
  final String previousPageTitle;
  final TvShowsCategories tvShowCategory;
  final TvShowsList tvShowsList;
  final int tvShowId;

  SeeAllTvShows(
      {@required this.previousPageTitle,
      @required this.tvShowCategory,
      @required this.tvShowsList,
      @required this.tvShowId});

  @override
  _SeeAllTvShowsState createState() => _SeeAllTvShowsState();
}

class _SeeAllTvShowsState extends State<SeeAllTvShows> {
  List<TvShowsData> _tvShows;
  int totalPages;
  int pageNumber;
  bool tvShowsItemsLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tvShows = widget.tvShowsList.tvShows;
    pageNumber = widget.tvShowsList.pageNumber;
    totalPages = widget.tvShowsList.totalPages;

    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        if (tvShowsItemsLoading == false) {
          _getTvShows();
        }
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _getTvShows() async {
    tvShowsItemsLoading = true;
    pageNumber++;
    TvShowsList tvShowsList = await getCategoryTvShows(http.Client(),
        widget.tvShowId, widget.tvShowCategory, pageNumber);
    setState(() {
      if (tvShowsList != null &&
          tvShowsList.tvShows != null &&
          tvShowsList.tvShows.isNotEmpty) {
        _tvShows.addAll(tvShowsList.tvShows);
      }
      tvShowsItemsLoading = false;
    });
  }

  void _navigateToTvShowDetails(
      int id, String movieTitle, TvShowsCategories category) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: tvShowsCategoryName[category],
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: tvShowsCategoryName[category],
                    )));
  }

  Widget get _buildSeeAllTvShowsWidget {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double topPadding = padding.top + kToolbarHeight + 5;
    final double bottomPadding = padding.bottom + 30;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: isIOS
            ? EdgeInsets.only(top: topPadding, left: 10, bottom: bottomPadding)
            : const EdgeInsets.only(top: 20, left: 10, bottom: 20),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToTvShowDetails(_tvShows[index].id, _tvShows[index].name,
                  widget.tvShowCategory);
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
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Image.network(
                          IMAGE_BASE_URL +
                              PosterSizes.w92 +
                              _tvShows[index].posterPath,
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
                            _tvShows[index].name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 8),
                          child: Text(
                            getTvShowsGenres(_tvShows[index].genreIds),
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 5),
                          child: buildRatingWidget(_tvShows[index].voteAverage,
                              _tvShows[index].voteCount),
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
        itemCount: _tvShows.length);
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  tvShowsCategoryName[widget.tvShowCategory],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeeAllTvShowsWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text(tvShowsCategoryName[widget.tvShowCategory]),
            ),
            body: _buildSeeAllTvShowsWidget,
          );
  }
}
