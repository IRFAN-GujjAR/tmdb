import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/network/search_api.dart';
import 'package:tmdb/utils/utils.dart';

class CelebritiesSearch extends StatefulWidget {
  final String searchQuery;
  final CelebritiesList celebritiesList;

  CelebritiesSearch(
      {
      @required this.celebritiesList,
      @required this.searchQuery});

  @override
  _CelebritiesSearchState createState() => _CelebritiesSearchState();
}

class _CelebritiesSearchState extends State<CelebritiesSearch>
    with AutomaticKeepAliveClientMixin<CelebritiesSearch> {
  List<CelebritiesData> _celebrities;
  int _totalPages;
  int _pageNumber;
  bool _moviesItemLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _celebrities = widget.celebritiesList.celebrities;
    _pageNumber = widget.celebritiesList.pageNumber;
    _totalPages = widget.celebritiesList.totalPages;

    _scrollController.addListener(() {
      double scrollLimit = (_scrollController.position.maxScrollExtent / 5) * 3;
      if (_scrollController.position.pixels > scrollLimit) {
        if (_moviesItemLoading == false) {
          if (_pageNumber < _totalPages) {
            _getSearchedCelebrities();
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
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getSearchedCelebrities() async {
    _moviesItemLoading = true;
    _pageNumber++;
    CelebritiesList celebritiesList = await searchCelebrities(
        http.Client(), widget.searchQuery, _pageNumber);
    setState(() {
      _celebrities.addAll(celebritiesList.celebrities);
      _moviesItemLoading = false;
    });
  }

  void _navigateToCelebritiesDetails(int id, String celebName) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: celebName,
                      previousPageTitle: 'Back',
                    ))
            : MaterialPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: celebName,
                      previousPageTitle: 'Back',
                    )));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bottomPadding=MediaQuery.of(context).padding.bottom+20;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 10, top: 20, bottom:isIOS?bottomPadding:20),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToCelebritiesDetails(
                  _celebrities[index].id, _celebrities[index].name);
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
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: _celebrities[index].profilePath != null
                          ? Image.network(
                              IMAGE_BASE_URL +
                                  ProfileSizes.w185 +
                                  _celebrities[index].profilePath,
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
                            _celebrities[index].name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Text(
                            _celebrities[index].knownFor,
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
        itemCount: _celebrities.length);
  }

  @override
  bool get wantKeepAlive => true;
}
