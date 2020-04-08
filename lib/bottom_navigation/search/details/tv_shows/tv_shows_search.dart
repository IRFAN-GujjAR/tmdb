import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/tv_shows/details/tv_shows_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/tv_Shows_data.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/search_api.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/utils/utils.dart';

class TvShowsSearch extends StatefulWidget {
  final String searchQuery;
  final TvShowsList tvShowsList;

  TvShowsSearch(
      {
      @required this.tvShowsList,
      @required this.searchQuery});

  @override
  _TvShowsSearchState createState() => _TvShowsSearchState();
}

class _TvShowsSearchState extends State<TvShowsSearch>
    with AutomaticKeepAliveClientMixin<TvShowsSearch> {
  List<TvShowsData> _tvShows;
  int _totalPages;
  int _pageNumber;
  bool _tvShowsItemsLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tvShows = widget.tvShowsList.tvShows;
    _pageNumber = 1;
    _totalPages = widget.tvShowsList.totalPages;

    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        if (_tvShowsItemsLoading == false) {
          if (_pageNumber < _totalPages) {
            _getSearchedTvShows();
          }
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

  Future<void> _getSearchedTvShows() async {
    _tvShowsItemsLoading = true;
    _pageNumber++;
    TvShowsList tvShowsList = await searchTvShows(
        http.Client(), widget.searchQuery, _pageNumber);
    setState(() {
      _tvShows.addAll(tvShowsList.tvShows);
      _tvShowsItemsLoading = false;
    });
  }


  void _navigateToTvShowDetails(int id, String movieTitle) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: movieTitle,
                      previousPageTitle: 'Back',
                    )));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding=MediaQuery.of(context).padding.bottom+20;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, top: 20, bottom: bottomPadding),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToTvShowDetails(
                  _tvShows[index].id, _tvShows[index].name);
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
  bool get wantKeepAlive => true;
}
