import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/search/details/search_details.dart';
import 'package:tmdb/bottom_navigation/search/search_bar.dart';
import 'package:tmdb/bottom_navigation/search/search_data_delegate.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/movie_tv_show_app.dart';
import 'package:tmdb/network/search_api.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {

  Search({Key key}) : super(key: key);

  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  List<String> _trendingSearches = [];
  int length = 0;
  bool _isLoading = true;
  bool _isInternet = true;
  String _typedText = '';
  bool _isUpdated = false;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
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
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeSearch();
      }
    });
    _initializeSearch();
  }

  void _initializeSearch() async {
    setState(() {
      _isLoading = true;
    });
    _trendingSearches = await getTrendingSearches(http.Client());
    if (_trendingSearches != null) {
      if (_trendingSearches.isNotEmpty) {
        setState(() {
          length = (_trendingSearches.length / 2).round() - 2;
        });
      }
      setState(() {
        _isInternet = true;
      });
    } else {
      setState(() {
        _isInternet = false;
      });
    }
    setState(() {
      _isLoading = false;
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
    _searchTextController.dispose();
    _searchFocusNode.dispose();
    _animationController.dispose();
    _subscription.cancel();
  }

  void _cancelSearch() {
    setState(() {
      _typedText = '';
    });
    _searchTextController.clear();
    _searchFocusNode.unfocus();
    _animationController.reverse();
  }

  void _clearSearch() {
    setState(() {
      _typedText = '';
    });
    _searchTextController.clear();
    _searchFocusNode.unfocus();
  }

  void _onUpdate(String text) {
    setState(() {
      _typedText = text;
      _isUpdated = true;
    });
  }

  void _onSubmit(String text) {
    if (!isIOS) {
      showSearch(
          context: context,
          delegate: SearchDataDelegate(),
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

  Widget get _buildSearches {
    return FutureBuilder(
      future: getSearchQueries(http.Client(), _typedText),
      builder:
          (BuildContext context, AsyncSnapshot<List<String>> searchQueries) {
        if (searchQueries.hasError) {
          print(searchQueries.error);
        }

        int length = 0;
        if (searchQueries.hasData) {
          length = searchQueries.data.length;
          if (length < 18) {
            length = 18;
          }
        }

        return searchQueries.hasData
            ? Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _onSubmit(searchQueries.data[index]);
                        },
                        child: Container(
                            decoration:
                                BoxDecoration(border: Border.all(width: 0)),
                            margin: const EdgeInsets.only(left: 10),
                            child: index < searchQueries.data.length
                                ? Text(searchQueries.data[index])
                                : SizedBox(
                                    height: 10,
                                  )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 0.3,
                        height: 20,
                        indent: 10,
                        color: Colors.grey,
                      );
                    },
                    itemCount: length))
            : Center(child: CupertinoActivityIndicator());
      },
    );
  }

  Widget get _buildSearchWidget {
    final padding = MediaQuery.of(context).padding;
    final topPadding = padding.top + kToolbarHeight - 12;

    return GestureDetector(
        onTapUp: (TapUpDetails _) {
          _searchFocusNode.unfocus();
          if (_searchTextController.text == '') {
            _animationController.reverse();
          }
        },
        child: !_isLoading
            ? _typedText.isEmpty
                ? _isInternet
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
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Text(
                                            _trendingSearches[index],
                                            style: TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                          onPressed: () {
                                            _onSubmit(_trendingSearches[index]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return CupertinoButton(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  _trendingSearches[index],
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  _onSubmit(_trendingSearches[index]);
                                },
                              );
                            },
                            itemCount: length),
                      )
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeSearch,
                      )
                : _isUpdated
                    ? _buildSearches
                    : isIOS
                        ? Padding(
                            padding: EdgeInsets.only(top: topPadding),
                            child: SearchDetails(
                              typedText: _typedText,
                            ),
                          )
                        : Container()
            : Center(
                child: isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator()));
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
                onCancel: _cancelSearch,
                onClear: _clearSearch,
                onUpdate: _onUpdate,
                onSubmit: _onSubmit,
              ),
            ),
            child: _buildSearchWidget)
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
                        ));
                  },
                )
              ],
            ),
            body: _buildSearchWidget,
          );
  }
}
