import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/celebrities_bloc.dart';
import 'package:tmdb/bloc/home/celebrities/celebrities_events.dart';
import 'package:tmdb/bloc/home/celebrities/celebrities_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_repo.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/see_all/see_all_celebrities.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/movie_tv_show_app.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

Map<CelebrityCategories, String> celebritiesCategoryName = {
  CelebrityCategories.Popular: 'Popular',
  CelebrityCategories.Trending: 'Trending',
};

class Celebrities extends StatefulWidget {
  @override
  _CelebritiesState createState() => _CelebritiesState();
}

class _CelebritiesState extends State<Celebrities> {
  CelebritiesBloc _celebritiesBloc;

  @override
  void initState() {
    _celebritiesBloc = CelebritiesBloc(
        celebritiesRepo: CelebritiesRepo(client: getHttpClient(context)));
    _initializeCelebrities();
    super.initState();
  }

  void _initializeCelebrities() {
    _celebritiesBloc.add(CelebritiesEvents.Load);
  }

  @override
  void dispose() {
    _celebritiesBloc.close();
    super.dispose();
  }

  void _navigateToSeeAllCelebrities(BuildContext context,
      CelebrityCategories category, CelebritiesList celebritiesList) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (context) {
                return SeeAllCelebrities(
                  previousPageTitle: 'Celebrities',
                  celebrityCategory: category,
                  celebritiesList: celebritiesList,
                );
              })
            : MaterialPageRoute(builder: (context) {
                return SeeAllCelebrities(
                  previousPageTitle: 'Celebrities',
                  celebrityCategory: category,
                  celebritiesList: celebritiesList,
                );
              }));
  }

  Widget _buildTextRow(BuildContext context, CelebrityCategories category,
      CelebritiesList celebritiesList) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Text(
            celebritiesCategoryName[category],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllCelebrities(context, category, celebritiesList);
            },
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    'See all',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Icon(CupertinoIcons.forward, color: Colors.grey, size: 14)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get _divider {
    return Container(
        margin: const EdgeInsets.only(left: 12),
        height: 0.8,
        color: Colors.grey[900]);
  }

  void _navigateToCelebritiesDetails(
      BuildContext context, CelebritiesData celeb) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(builder: (BuildContext context) {
                return CelebritiesDetails(
                  id: celeb.id,
                  celebName: celeb.name,
                  previousPageTitle: 'Celebrities',
                );
              })
            : MaterialPageRoute(builder: (context) {
                return CelebritiesDetails(
                  id: celeb.id,
                  celebName: celeb.name,
                  previousPageTitle: 'Celebrities',
                );
              }));
  }

  Widget _buildPopularCelebs(List<CelebritiesData> celebs) {
    final double listViewHeight = 200;
    final double imageHeight = 130;
    final double listItemWidth = 100;

    return Container(
      height: listViewHeight,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: celebs.length,
        padding: const EdgeInsets.only(left: 12, right: 12),
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            width: 32,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _navigateToCelebritiesDetails(context, celebs[index]);
            },
            child: Container(
              width: listItemWidth,
              child: Column(
                children: <Widget>[
                  Container(
                      height: imageHeight,
                      width: listItemWidth,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: celebs[index].profilePath != null
                            ? Image.network(
                                IMAGE_BASE_URL +
                                    ProfileSizes.w185 +
                                    celebs[index].profilePath,
                                fit: BoxFit.fitWidth)
                            : Icon(
                                CupertinoIcons.person_solid,
                                size: 100,
                                color: Colors.grey,
                              ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        celebs[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        celebs[index].knownFor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 12),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingCelebsItems(
      BuildContext context, CelebritiesData celeb) {
    return GestureDetector(
      onTap: () {
        _navigateToCelebritiesDetails(context, celeb);
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(width: 0, style: BorderStyle.none)),
        child: Row(
          children: <Widget>[
            Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(35)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: celeb.profilePath != null
                      ? Image.network(
                          IMAGE_BASE_URL +
                              ProfileSizes.w185 +
                              celeb.profilePath,
                          fit: BoxFit.fitWidth,
                        )
                      : Container(
                          alignment: Alignment.topCenter,
                          child: Icon(
                            CupertinoIcons.person_solid,
                            size: 65,
                            color: Colors.grey,
                          ),
                        ),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: Text(
                      celeb.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 2),
                  child: Text(
                    celeb.knownFor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Spacer(),
            Icon(
              CupertinoIcons.forward,
              color: Colors.grey,
              size: 18,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingCelebs(List<CelebritiesData> celebs) {
    List<CelebritiesData> firstPairCelebs;
    List<CelebritiesData> secondPairCelebs;
    List<CelebritiesData> thirdPairCelebs;

    for (int i = 0; i < 12; i++) {
      if (i >= 0 && i <= 3) {
        if (firstPairCelebs == null) {
          firstPairCelebs = [celebs[i]];
        } else {
          firstPairCelebs.add(celebs[i]);
        }
      } else if (i >= 4 && i <= 7) {
        if (secondPairCelebs == null) {
          secondPairCelebs = [celebs[i]];
        } else {
          secondPairCelebs.add(celebs[i]);
        }
      } else if (i >= 8 && i <= 11) {
        if (thirdPairCelebs == null) {
          thirdPairCelebs = [celebs[i]];
        } else {
          thirdPairCelebs.add(celebs[i]);
        }
      }
    }

    return Container(
      height: 350,
      child: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int mainIndex) {
            return Container(
              margin: const EdgeInsets.only(left: 12),
              width: 310,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getTopRatedItems(context, mainIndex, 0, firstPairCelebs,
                      secondPairCelebs, thirdPairCelebs),
                  _getTopRatedItems(context, mainIndex, 1, firstPairCelebs,
                      secondPairCelebs, thirdPairCelebs),
                  _getTopRatedItems(context, mainIndex, 2, firstPairCelebs,
                      secondPairCelebs, thirdPairCelebs),
                  _getTopRatedItems(context, mainIndex, 3, firstPairCelebs,
                      secondPairCelebs, thirdPairCelebs),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              width: 8,
            );
          },
          itemCount: 3),
    );
  }

  Widget _getTopRatedItems(
    BuildContext context,
    int mainIndex,
    int itemIndex,
    List<CelebritiesData> firstPairCelebs,
    List<CelebritiesData> secondPairCelebs,
    List<CelebritiesData> thirdPairCelebs,
  ) {
    switch (mainIndex) {
      case 0:
        return _buildTrendingCelebsItems(context, firstPairCelebs[itemIndex]);
      case 1:
        return _buildTrendingCelebsItems(context, secondPairCelebs[itemIndex]);
      case 2:
        return _buildTrendingCelebsItems(context, thirdPairCelebs[itemIndex]);
    }
    return null;
  }

  Widget get _buildCelebrities {
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double bottomPadding = padding.bottom + 20;

    return BlocBuilder<CelebritiesBloc, CelebritiesState>(
        cubit: _celebritiesBloc,
        builder: (context, celebritiesState) {
          if (celebritiesState is CelebritiesLoaded) {
            final celebritiesLists = celebritiesState.celebritiesLists;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: isIOS ? bottomPadding : 10, top: isIOS ? 10 : 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildTextRow(context, CelebrityCategories.Popular,
                        celebritiesLists[0]),
                    _buildPopularCelebs(celebritiesState.firstHalfPopular),
                    _buildPopularCelebs(celebritiesState.secondHalfPopular),
                    _divider,
                    _buildTextRow(context, CelebrityCategories.Trending,
                        celebritiesLists[1]),
                    _buildTrendingCelebs(celebritiesLists[1].celebrities)
                  ],
                ),
              ),
            );
          } else if (celebritiesState is CelebritiesLoadingError) {
            return InternetConnectionErrorWidget(
                onPressed: _initializeCelebrities);
          }

          return LoadingWidget();
        });
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            child: CustomScrollView(
              slivers: <Widget>[
                CupertinoSliverNavigationBar(
                  largeTitle: Text(tabName[TabItem.celebs]),
                ),
                SliverFillRemaining(
                    hasScrollBody: false, child: _buildCelebrities)
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(tabName[TabItem.celebs]),
            ),
            body: _buildCelebrities,
          );
  }
}
