import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_events.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_states.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/celebrities/see_all/see_all_celebrities_repo.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';

import '../../../../main.dart';
import '../celebrities.dart';

class SeeAllCelebrities extends StatefulWidget {
  final String previousPageTitle;
  final CelebrityCategories celebrityCategory;
  final CelebritiesList celebritiesList;

  SeeAllCelebrities(
      {@required this.previousPageTitle,
      @required this.celebrityCategory,
      @required this.celebritiesList});

  @override
  _SeeAllCelebritiesState createState() => _SeeAllCelebritiesState();
}

class _SeeAllCelebritiesState extends State<SeeAllCelebrities> {
  SeeAllCelebritiesBloc _seeAllCelebritiesBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  final String imageBaseUrl = 'https://image.tmdb.org/t/p/w92';

  @override
  void initState() {
    _seeAllCelebritiesBloc = SeeAllCelebritiesBloc(
        seeAllCelebritiesRepo:
            SeeAllCelebritiesRepo(client: getHttpClient(context)),
        celebritiesList: widget.celebritiesList);
    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllCelebritiesBloc.state is SeeAllCelebritiesLoadingMore)) {
        _getCelebrities();
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
    _scrollControllerUtil.dispose();
    _seeAllCelebritiesBloc.close();
    super.dispose();
  }

  void _getCelebrities() {
    final celebritiesList = _seeAllCelebritiesBloc.celebritiesList;
    if (celebritiesList.pageNumber < celebritiesList.totalPages) {
      final pageNumber = celebritiesList.pageNumber + 1;
      _seeAllCelebritiesBloc.add(LoadMoreSeeAllCelebrities(
          previousCelebrities: celebritiesList,
          url: widget.celebrityCategory == CelebrityCategories.Popular
              ? URLS.popularCelebrities(pageNumber)
              : URLS.trendingCelebrities(pageNumber)));
    }
  }

  void _navigateToCelebritiesDetails(
      int id, String celebName, CelebrityCategories category) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: celebName,
                      previousPageTitle: celebritiesCategoryName[category],
                    ))
            : MaterialPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: celebName,
                      previousPageTitle: celebritiesCategoryName[category],
                    )));
  }

  Widget get _buildSeeAllCelebrities {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double topPadding = padding.top + kToolbarHeight + 5;
    final double bottomPadding = padding.bottom + 20;

    return BlocBuilder<SeeAllCelebritiesBloc, SeeAllCelebritiesState>(
        cubit: _seeAllCelebritiesBloc,
        builder: (context, state) {
          final celebrities =
              _seeAllCelebritiesBloc.celebritiesList.celebrities;
          return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: isIOS
                  ? EdgeInsets.only(
                      top: topPadding, left: 10, bottom: bottomPadding)
                  : const EdgeInsets.only(top: 20, left: 10, bottom: 20),
              controller: _scrollControllerUtil.scrollController,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToCelebritiesDetails(celebrities[index].id,
                        celebrities[index].name, widget.celebrityCategory);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0, style: BorderStyle.none)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            width: 70,
                            height: 105,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                            ),
                            child: celebrities[index].profilePath != null
                                ? Image.network(
                                    imageBaseUrl +
                                        celebrities[index].profilePath,
                                    fit: BoxFit.fitHeight,
                                  )
                                : Icon(
                                    CupertinoIcons.person_solid,
                                    size: 80,
                                    color: Colors.grey,
                                  )),
                        Container(
                          width: 250,
                          padding: const EdgeInsets.only(top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  celebrities[index].name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8),
                                child: Text(
                                  celebrities[index].knownFor,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, right: 10),
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
              itemCount: celebrities.length);
        });
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
                  celebritiesCategoryName[widget.celebrityCategory],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeeAllCelebrities,
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(celebritiesCategoryName[widget.celebrityCategory]),
            ),
            body: _buildSeeAllCelebrities,
          );
  }
}
