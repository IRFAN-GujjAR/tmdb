import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_events.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/celebrities/see_all/see_all_celebrities_repo.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/scroll_controller/scroll_controller_util.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

class CelebritiesSearch extends StatefulWidget {
  final String searchQuery;
  final CelebritiesList celebritiesList;

  CelebritiesSearch(
      {@required this.celebritiesList, @required this.searchQuery});

  @override
  _CelebritiesSearchState createState() => _CelebritiesSearchState();
}

class _CelebritiesSearchState extends State<CelebritiesSearch>
    with AutomaticKeepAliveClientMixin<CelebritiesSearch> {
  SeeAllCelebritiesBloc _seeAllCelebritiesBloc;
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    _seeAllCelebritiesBloc = SeeAllCelebritiesBloc(
        seeAllCelebritiesRepo:
            SeeAllCelebritiesRepo(client: getHttpClient(context)),
        celebritiesList: widget.celebritiesList);
    _scrollControllerUtil.addScrollListener(() {
      if (!(_seeAllCelebritiesBloc.state is SeeAllCelebritiesLoadingMore)) {
        _getSearchedCelebrities();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerUtil.dispose();
    _seeAllCelebritiesBloc.close();
    super.dispose();
  }

  void _getSearchedCelebrities() {
    final celebritiesList = _seeAllCelebritiesBloc.celebritiesList;
    if (celebritiesList.pageNumber < celebritiesList.totalPages) {
      final pageNumber = celebritiesList.pageNumber + 1;
      _seeAllCelebritiesBloc.add(LoadMoreSeeAllCelebrities(
          previousCelebrities: celebritiesList,
          url: URLS.searchCelebritiest(widget.searchQuery, pageNumber)));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var bottomPadding = MediaQuery.of(context).padding.bottom + 20;

    return BlocBuilder<SeeAllCelebritiesBloc, SeeAllCelebritiesState>(
      cubit: _seeAllCelebritiesBloc,
      builder: (context, state) {
        final celebrities = _seeAllCelebritiesBloc.celebritiesList.celebrities;

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
                      page: CelebritiesDetails(
                          id: celebrities[index].id,
                          celebName: celebrities[index].name,
                          previousPageTitle: 'Back'));
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
                          child: celebrities[index].profilePath != null
                              ? Image.network(
                                  IMAGE_BASE_URL +
                                      ProfileSizes.w185 +
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
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8),
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
