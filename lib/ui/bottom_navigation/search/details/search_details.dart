import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/details/search_details_bloc.dart';
import 'package:tmdb/bloc/home/search/details/search_details_events.dart';
import 'package:tmdb/bloc/home/search/details/search_details_states.dart';
import 'package:tmdb/models/search_details_model.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/search/details/search_details_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/search/details/all/all_search.dart';
import 'package:tmdb/ui/bottom_navigation/search/details/celebs/celebs_search.dart';
import 'package:tmdb/ui/bottom_navigation/search/details/movies/movies_search.dart';
import 'package:tmdb/ui/bottom_navigation/search/details/tv_shows/tv_shows_search.dart';
import 'package:tmdb/ui/movie_tv_show_app.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

enum _SearchCategories { All, Movies, TvShows, Celebs }

class SearchDetails extends StatefulWidget {
  final String typedText;

  SearchDetails({
    @required this.typedText,
  });

  @override
  _SearchDetailsState createState() => _SearchDetailsState();
}

class _SearchDetailsState extends State<SearchDetails>
    with SingleTickerProviderStateMixin<SearchDetails> {
  Map<_SearchCategories, String> _categoryName = {
    _SearchCategories.All: 'All',
    _SearchCategories.Movies: 'Movies',
    _SearchCategories.TvShows: 'Tv Shows',
    _SearchCategories.Celebs: 'Celebs'
  };

  SearchDetailsBloc _searchDetailsBloc;
  TabController _tabController;
  _SearchCategories _searchCategory = _SearchCategories.All;

  @override
  void initState() {
    _searchDetailsBloc = SearchDetailsBloc(
        searchDetailsRepo: SearchDetailsRepo(client: getHttpClient(context)));
    _initializeSearchDetailsBloc();
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
    _searchDetailsBloc.close();
    if (_tabController != null) {
      _tabController.dispose();
    }
    super.dispose();
  }

  void _initializeSearchDetailsBloc() {
    _searchDetailsBloc.add(LoadSearchDetails(query: widget.typedText));
  }

  void _initializeTabBarController(SearchDetailsModel searchDetails) {
    int length = 0;
    if (searchDetails.isMovies) length++;
    if (searchDetails.isTvShows) length++;
    if (searchDetails.isCelebrities) length++;
    if (length == 3) length++;
    _tabController = TabController(length: length, vsync: this);
  }

  List<Widget> _buildPages(SearchDetailsModel searchDetails) {
    List<Widget> pages = [];
    if (searchDetails.isMovies &&
        searchDetails.isTvShows &&
        searchDetails.isCelebrities) {
      pages = [
        AllSearch(
          onClickSeeAll: (tabItem) {
            if (tabItem == TabItem.movies) {
              setState(() {
                _searchCategory = _SearchCategories.Movies;
                _tabController.index = 1;
              });
            } else if (tabItem == TabItem.tvShows) {
              setState(() {
                _searchCategory = _SearchCategories.TvShows;
                _tabController.index = 2;
              });
            } else if (tabItem == TabItem.celebs) {
              setState(() {
                _searchCategory = _SearchCategories.Celebs;
                _tabController.index = 3;
              });
            }
          },
          moviesList: searchDetails.moviesList,
          tvShowsList: searchDetails.tvShowsList,
          celebritiesList: searchDetails.celebritiesList,
        ),
        MoviesSearch(
          searchQuery: widget.typedText,
          moviesList: searchDetails.moviesList,
        ),
        TvShowsSearch(
          searchQuery: widget.typedText,
          tvShowsList: searchDetails.tvShowsList,
        ),
        CelebritiesSearch(
          searchQuery: widget.typedText,
          celebritiesList: searchDetails.celebritiesList,
        ),
      ];

      return pages;
    } else {
      if (searchDetails.isMovies) {
        pages.add(MoviesSearch(
          searchQuery: widget.typedText,
          moviesList: searchDetails.moviesList,
        ));
      }
      if (searchDetails.isTvShows) {
        pages.add(TvShowsSearch(
          searchQuery: widget.typedText,
          tvShowsList: searchDetails.tvShowsList,
        ));
      }
      if (searchDetails.isCelebrities) {
        pages.add(CelebritiesSearch(
          searchQuery: widget.typedText,
          celebritiesList: searchDetails.celebritiesList,
        ));
      }
    }

    return pages;
  }

  void _onTabBarItemClicked(int tabBarLength, _SearchCategories searchCategory,
      SearchDetailsModel searchDetails) {
    setState(() {
      _searchCategory = searchCategory;
      if (tabBarLength == 4) {
        switch (searchCategory) {
          case _SearchCategories.All:
            _tabController.index = 0;
            break;
          case _SearchCategories.Movies:
            _tabController.index = 1;
            break;
          case _SearchCategories.TvShows:
            _tabController.index = 2;
            break;
          case _SearchCategories.Celebs:
            _tabController.index = 3;
            break;
        }
      } else if (tabBarLength == 3) {
        switch (searchCategory) {
          case _SearchCategories.Movies:
            _tabController.index = 0;
            break;
          case _SearchCategories.TvShows:
            _tabController.index = 1;
            break;
          case _SearchCategories.Celebs:
            _tabController.index = 2;
            break;
          default:
        }
      } else if (tabBarLength == 2) {
        if (searchDetails.isMovies && searchDetails.isTvShows) {
          switch (searchCategory) {
            case _SearchCategories.Movies:
              _tabController.index = 0;
              break;
            case _SearchCategories.TvShows:
              _tabController.index = 1;
              break;
            default:
          }
        } else if (searchDetails.isMovies && searchDetails.isCelebrities) {
          switch (searchCategory) {
            case _SearchCategories.Movies:
              _tabController.index = 0;
              break;
            case _SearchCategories.Celebs:
              _tabController.index = 1;
              break;
            default:
          }
        } else if (searchDetails.isTvShows && searchDetails.isCelebrities) {
          switch (searchCategory) {
            case _SearchCategories.TvShows:
              _tabController.index = 0;
              break;
            case _SearchCategories.Celebs:
              _tabController.index = 1;
              break;
            default:
          }
        }
      }
    });
  }

  Widget _buildTabs(SearchDetailsModel searchDetails) {
    Map<_SearchCategories, Widget> tabBars = {};
    if (searchDetails.isMovies &&
        searchDetails.isTvShows &&
        searchDetails.isCelebrities) {
      tabBars = {
        _SearchCategories.All: _buildTabTitle(_SearchCategories.All),
        _SearchCategories.Movies: _buildTabTitle(_SearchCategories.Movies),
        _SearchCategories.TvShows: _buildTabTitle(_SearchCategories.TvShows),
        _SearchCategories.Celebs: _buildTabTitle(_SearchCategories.Celebs),
      };
    } else {
      if (searchDetails.isMovies) {
        tabBars.addAll({
          _SearchCategories.Movies: _buildTabTitle(_SearchCategories.Movies)
        });
      }
      if (searchDetails.isTvShows) {
        tabBars.addAll({
          _SearchCategories.TvShows: _buildTabTitle(_SearchCategories.TvShows)
        });
      }
      if (searchDetails.isCelebrities) {
        tabBars.addAll({
          _SearchCategories.Celebs: _buildTabTitle(_SearchCategories.Celebs)
        });
      }
      if (tabBars.length < 2) {
        return Container();
      }
    }

    return Container(
        color: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[900],
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoSlidingSegmentedControl<_SearchCategories>(
                groupValue: _searchCategory,
                children: tabBars,
                onValueChanged: (value) {
                  _onTabBarItemClicked(tabBars.length, value, searchDetails);
                }),
          ],
        ));
  }

  Widget _buildTabTitle(_SearchCategories searchCategory) {
    return Text(
      _categoryName[searchCategory],
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchDetailsBloc, SearchDetailsState>(
        cubit: _searchDetailsBloc,
        listener: (context, state) {
          if (state is SearchDetailsLoaded) {
            _initializeTabBarController(state.searchDetails);
          }
        },
        builder: (context, state) {
          if (state is SearchDetailsLoaded) {
            return Container(
              child: Column(
                children: <Widget>[
                  _buildTabs(state.searchDetails),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: _buildPages(state.searchDetails),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is SearchDetailsEmpty) {
            return Center(
              child: Text('No results found!'),
            );
          } else if (state is SearchDetailsLoadingError) {
            return InternetConnectionErrorWidget(
                onPressed: _initializeSearchDetailsBloc);
          }
          return LoadingWidget();
        });
  }
}
