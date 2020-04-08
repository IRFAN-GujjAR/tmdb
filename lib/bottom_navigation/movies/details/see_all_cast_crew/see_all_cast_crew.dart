import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tmdb/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/common.dart' as models;
import 'package:cupertino_tabbar/cupertino_tabbar.dart' as customTabBar;
import 'package:tmdb/utils/utils.dart';

class SeeAllCastCrew extends StatefulWidget {
  final String previousPageTitle;
  final models.Credits credits;

  SeeAllCastCrew(
      {@required this.previousPageTitle,
      @required this.credits});

  @override
  _SeeAllCastCrewState createState() => _SeeAllCastCrewState();
}

class _SeeAllCastCrewState extends State<SeeAllCastCrew>
    with SingleTickerProviderStateMixin<SeeAllCastCrew> {
  TabController _tabController;

  int cupertinoTabBarValue = 0;

  int cupertinoTabBarValueGetter() => cupertinoTabBarValue;

  @override
  void initState() {
    super.initState();

    int length = 0;

    if ((widget.credits.cast != null && widget.credits.cast.isNotEmpty) &&
        (widget.credits.crew != null && widget.credits.crew.isNotEmpty)) {
      length = 2;
    } else {
      length = 1;
    }

    _tabController =
        TabController(initialIndex: 0, length: length, vsync: this);
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
    _tabController.dispose();
  }

  List<Widget> get _buildPages {
    List<Widget> pages = [];

    if (widget.credits.cast != null && widget.credits.cast.isNotEmpty) {
      pages.add(AllCredits(
        cast: widget.credits.cast,
        crew: null,
      ));
    }
    if (widget.credits.crew != null && widget.credits.crew.isNotEmpty) {
      pages.add(AllCredits(
        crew: widget.credits.crew,
        cast: null,
      ));
    }

    return pages;
  }

  Widget _buildTabTitle(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget get _buildTabs {
    List<Widget> titles = [];
    if (widget.credits.cast != null && widget.credits.cast.isNotEmpty) {
      titles.add(_buildTabTitle('Cast'));
    }
    if (widget.credits.crew != null && widget.credits.crew.isNotEmpty) {
      titles.add(_buildTabTitle('Crew'));
    }

    if (titles.length < 2) {
      return Container();
    }

    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        customTabBar.CupertinoTabBar(
          CupertinoColors.darkBackgroundGray,
          CupertinoColors.inactiveGray,
          titles,
          cupertinoTabBarValueGetter,
          (int index) {
            setState(() {
              cupertinoTabBarValue = index;
              _tabController.index = index;
            });
          },
          useSeparators: true,
          horizontalPadding: 10,
          verticalPadding: 8,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          duration: const Duration(milliseconds: 250),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {

    var topPadding=MediaQuery.of(context).padding.top+kToolbarHeight-12;

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  'Credits',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: topPadding),
                  child: _buildTabs,
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: _buildPages,
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Credits'),
            ),
            body: Column(
              children: <Widget>[
                _buildTabs,
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: _buildPages,
                  ),
                ),
              ],
            ),
          );
  }
}

class AllCredits extends StatefulWidget {
  final List<models.Cast> cast;
  final List<models.Crew> crew;

  AllCredits(
      {
      this.cast,
      this.crew});

  @override
  _AllCreditsState createState() => _AllCreditsState();
}

class _AllCreditsState extends State<AllCredits>
    with AutomaticKeepAliveClientMixin<AllCredits> {
  void _navigateToCelebritiesDetails(int id, String celebName) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return CelebritiesDetails(
                  id: id,
                  celebName: celebName,
                  previousPageTitle: 'Credits',
                );
              })
            : MaterialPageRoute(builder: (context) {
                return CelebritiesDetails(
                  id: id,
                  celebName: celebName,
                  previousPageTitle: 'Credits',
                );
              }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var bottomPadding=MediaQuery.of(context).padding.bottom+20;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: isIOS
            ? EdgeInsets.only(left: 10, top: 20, bottom: bottomPadding)
            : const EdgeInsets.only(left: 10, top: 20, bottom: 20),
        itemBuilder: (context, index) {
          String profilePath;
          String job;
          if (widget.cast == null) {
            profilePath = widget.crew[index].profilePath != null
                ? widget.crew[index].profilePath
                : null;
            job = widget.crew[index].job != null ? widget.crew[index].job : '';
          } else {
            profilePath = widget.cast[index].profilePath != null
                ? widget.cast[index].profilePath
                : null;
            job = 'Acting';
          }
          return GestureDetector(
            onTap: () {
              _navigateToCelebritiesDetails(
                  widget.cast == null
                      ? widget.crew[index].id
                      : widget.cast[index].id,
                  widget.cast == null
                      ? widget.crew[index].name
                      : widget.cast[index].name);
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
                      child: profilePath != null && profilePath.isNotEmpty
                          ? Image.network(
                              IMAGE_BASE_URL + ProfileSizes.w185 + profilePath,
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
                            widget.cast != null
                                ? widget.cast[index].name
                                : widget.crew[index].name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8),
                          child: Text(
                            job,
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
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
        itemCount:
            widget.cast != null ? widget.cast.length : widget.crew.length);
  }

  @override
  bool get wantKeepAlive => true;
}
