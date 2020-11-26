import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_bloc.dart';
import 'package:tmdb/bloc/home/search/multi_search/multi_search_events.dart';
import 'package:tmdb/bloc/home/search/trending/trending_search_bloc.dart';
import 'package:tmdb/bloc/home/search/trending/trending_search_events.dart';
import 'package:tmdb/bloc/home/search/trending/trending_search_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/search/search_repo.dart';
import 'package:tmdb/repositories/home/search/trending_search_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/search/details/search_details.dart';
import 'package:tmdb/ui/bottom_navigation/search/search_bar.dart';
import 'package:tmdb/ui/bottom_navigation/search/search_data_delegate.dart';
import 'package:tmdb/ui/bottom_navigation/search/search_widget.dart';
import 'package:tmdb/ui/movie_tv_show_app.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>
    with SingleTickerProviderStateMixin<Search> {
  final _searchTextController = TextEditingController();
  final _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  String _typedText = '';
  bool _isUpdated = false;

  TrendingSearchBloc _trendingSearchBloc;
  MultiSearchBloc _multiSearchBloc;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
    _trendingSearchBloc = TrendingSearchBloc(
        trendingSearchRepo: TrendingSearchRepo(client: getHttpClient(context)));
    _multiSearchBloc =
        MultiSearchBloc(searchRepo: SearchRepo(client: getHttpClient(context)));
    _initializeTrendingSearchBloc();
    super.initState();
  }

  void _initializeTrendingSearchBloc() {
    _trendingSearchBloc.add(TrendingSearchEvents.Load);
  }

  void cancelSearch() {
    setState(() {
      _typedText = '';
    });
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void clearSearch() {
    setState(() {
      _typedText = '';
    });
    _searchTextController.clear();
    _searchFocusNode.unfocus();
  }

  void onUpdate(String text) {
    setState(() {
      _typedText = text;
      _isUpdated = true;
    });

    _multiSearchBloc.add(SearchMultiSearch(query: _typedText));
  }

  void onSubmit(String text) {
    if (!isIOS) {
      showSearch(
          context: context,
          delegate: SearchDataDelegate(multiSearchBloc: _multiSearchBloc),
          query: text);
    } else {
      setState(() {
        _typedText = text;
        _isUpdated = false;
      });
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
      _searchTextController.text = text;
      _searchFocusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    _trendingSearchBloc.close();
    _multiSearchBloc.close();
    super.dispose();
  }

  Widget _buildSearchWidget(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    final topPadding = padding.top + kToolbarHeight - 12;
    return GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _animationController.reverse();
          }
        },
        child: BlocBuilder<TrendingSearchBloc, TrendingSearchState>(
            cubit: _trendingSearchBloc,
            builder: (context, trendingSearchState) {
              if (trendingSearchState is TrendingSearchesLoaded) {
                final trendingSearches = trendingSearchState.trendingSearches;
                final length = (trendingSearches.length / 2).round() - 2;

                return _typedText.isEmpty
                    ? Container(
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Trending',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: CupertinoButton(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            trendingSearches[index],
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            onSubmit(trendingSearches[index]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return CupertinoButton(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  trendingSearches[index],
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  onSubmit(trendingSearches[index]);
                                },
                              );
                            },
                            itemCount: length),
                      )
                    : _isUpdated
                        ? BlocProvider<MultiSearchBloc>.value(
                            value: _multiSearchBloc,
                            child: SearchWidget(
                                query: _typedText,
                                onSubmit: (value) {
                                  onSubmit(value);
                                }))
                        : isIOS
                            ? Padding(
                                padding: EdgeInsets.only(top: topPadding),
                                child: SearchDetails(
                                  typedText: _typedText,
                                ),
                              )
                            : Container();
              } else if (trendingSearchState is TrendingSearchesLoadingError) {
                return InternetConnectionErrorWidget(
                  onPressed: _initializeTrendingSearchBloc,
                );
              }

              return LoadingWidget();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: IOSSearchBar(
                controller: _searchTextController,
                focusNode: _searchFocusNode,
                animation: _animation,
                onCancel: cancelSearch,
                onClear: clearSearch,
                onUpdate: onUpdate,
                onSubmit: (value) {
                  onSubmit(value);
                },
              ),
            ),
            child: _buildSearchWidget(context))
        : Scaffold(
            appBar: AppBar(
              title: Text(tabName[TabItem.search]),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: SearchDataDelegate(
                            multiSearchBloc: _multiSearchBloc));
                  },
                )
              ],
            ),
            body: _buildSearchWidget(context),
          );
  }
}
