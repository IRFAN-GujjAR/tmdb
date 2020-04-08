import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/bottom_navigation/common/rating/Rate.dart';
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/details/see_all_cast_crew/see_all_cast_crew.dart';
import 'package:tmdb/bottom_navigation/tv_shows/details/see_all_seasons/see_all_seasons.dart';
import 'package:tmdb/bottom_navigation/tv_shows/season/season_details.dart';
import 'package:tmdb/bottom_navigation/tv_shows/see_all/see_all_tv_shows.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/network/details_api.dart';
import 'package:tmdb/models/details/common.dart' as models;
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/network/tmdb_account/tmdb_account_api.dart';
import 'package:tmdb/provider/movie_provider.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

enum _CategoryItems {
  seasons,
  castAndCrew,
  images,
  videos,
  recommended,
  similar
}

class TvShowDetails extends StatefulWidget {
  final int id;
  final String tvShowTitle;
  final String previousPageTitle;

  TvShowDetails(
      {
      @required this.id,
      @required this.tvShowTitle,
      @required this.previousPageTitle});

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  String _currentPageTitle = '';

  Map<_CategoryItems, String> _categoryName = {
    _CategoryItems.seasons: 'Seasons',
    _CategoryItems.castAndCrew: 'Cast & Crew',
    _CategoryItems.images: 'Images',
    _CategoryItems.videos: 'Videos',
    _CategoryItems.recommended: 'Recommended',
    _CategoryItems.similar: 'Similar'
  };

  TvShowDetailsData _tvShowDetailsData;
  bool _isTvShowDataLoaded = false;
  bool _isTMDbDataLoaded = false;
  bool _isTvShowFavourite = false;
  bool _isTvShowAddedToWatchList = false;
  bool _isTvShowRated = false;
  int _rating = 0;

  bool _isSignedIn = false;
  String _sessionId = '', _accountId = '';

  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeTvShowDetails();
        _checkTMDbData();
      }
    });
    _initializeTvShowDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> _initializeTvShowDetails() async {
    setState(() {
      _isTvShowDataLoaded = false;
    });
    _tvShowDetailsData =
        await fetchTvShowDetails(http.Client(), widget.id);
    if (_tvShowDetailsData == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      setState(() {
        _isInternet = true;
      });
    }
    setState(() {
      _isTvShowDataLoaded = true;
    });
  }

  Future<void> _checkTvShowIsFavourite() async {
    _isTvShowFavourite = await checkTvShowIsFavourite(
        http.Client(), _sessionId, _accountId, widget.id);
  }

  Future<void> _checkMovieIsRated() async {
    _rating = await checkTvShowIsRated(
        http.Client(), _sessionId, _accountId, widget.id);
    setState(() {
      _isTvShowRated = _rating != 0 ? true : false;
    });
  }

  Future<void> _checkTvShowIsAddedToWatchList() async {
    _isTvShowAddedToWatchList = await checkTvShowIsAddedToWatchList(
        http.Client(), _sessionId, _accountId, widget.id);
  }

  Widget _buildTvShowDetailsWidget(TvShowDetailsData tvShow) {
    _currentPageTitle = tvShow.name;

    final EdgeInsets padding = MediaQuery.of(context).padding;
    final bottomPadding = padding.bottom + 30;
    final topPadding = padding.top + kToolbarHeight;

    return SingleChildScrollView(
      padding: isIOS
          ? EdgeInsets.only(bottom: bottomPadding, top: topPadding)
          : const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 0)
                    : const EdgeInsets.only(top: 10),
                child: Container(
                    width: double.infinity,
                    height: 211,
                    child: Image.network(
                      IMAGE_BASE_URL + BackDropSizes.w780 + tvShow.backdropPath,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 136)
                    : const EdgeInsets.only(top: 150),
                child: Container(
                  width: double.infinity,
                  height: 76,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.9])),
                ),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(left: 5, top: 192)
                    : const EdgeInsets.only(left: 5, top: 202),
                child: Container(
                    width: 92,
                    height: 136,
                    child: Image.network(
                      IMAGE_BASE_URL + PosterSizes.w185 + tvShow.posterPath,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(left: 100, top: 190, right: 20)
                    : const EdgeInsets.only(left: 100, top: 200, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        tvShow.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: buildRatingWidget(
                              tvShow.voteAverage, tvShow.voteCount),
                        ),
                        Expanded(
                          flex: _isTvShowRated ? 1 : 2,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                '${_tvShowDetailsData.voteAverage}',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        _isTvShowRated
                            ? Expanded(
                                flex: 1,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '$_rating',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                    tvShow.genres != null && tvShow.genres.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: _buildGenresWidgets(tvShow.genres),
                          )
                        : Container(),
                    tvShow.overview != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: Text(
                              tvShow.overview,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ],
          ),
          tvShow.seasons != null && tvShow.seasons.isNotEmpty
              ? _buildSeasonsWidget(tvShow.seasons, tvShow.backdropPath)
              : _divider,
          tvShow.credits != null &&
                  tvShow.credits.cast != null &&
                  tvShow.credits.cast.isNotEmpty
              ? _buildCastAndCrewItems(tvShow.credits)
              : Container(),
          tvShow.videos.isNotEmpty
              ? _buildVideosItems(tvShow.videos)
              : Container(),
          _buildInformationWidget(tvShow),
          tvShow.recommendedTvShows != null &&
                  tvShow.recommendedTvShows.tvShows != null &&
                  tvShow.recommendedTvShows.tvShows.isNotEmpty
              ? _buildRecommendedOrSimilarTvShows(
                  tvShow.recommendedTvShows, _CategoryItems.recommended)
              : Container(),
          tvShow.similarTvShows != null &&
                  tvShow.similarTvShows.tvShows != null &&
                  tvShow.similarTvShows.tvShows.isNotEmpty
              ? _buildRecommendedOrSimilarTvShows(
                  tvShow.similarTvShows, _CategoryItems.similar)
              : Container(),
        ],
      ),
    );
  }

  Widget _buildGenresWidgets(List<models.Genre> genres) {
    return Container(
      height: 30,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Text(genres[index].name,
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10,
            );
          },
          itemCount: genres.length),
    );
  }

  Widget get _divider {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 15.0),
      height: 0.5,
      color: Colors.grey[900],
    );
  }

  Widget _buildTextRow(_CategoryItems item) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          item != _CategoryItems.videos
              ? CupertinoButton(
                  onPressed: () {},
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
              : Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                )
        ],
      ),
    );
  }

  void _navigateToSeeAllSimilarOrRecommendedTvShows(
      TvShowsCategories tvShowsCategory, TvShowsList tvShowsList) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeeAllTvShows(
                      previousPageTitle: widget.tvShowTitle,
                      tvShowCategory: tvShowsCategory,
                      tvShowsList: tvShowsList,
                      tvShowId: widget.id,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeeAllTvShows(
                      previousPageTitle: widget.tvShowTitle,
                      tvShowCategory: tvShowsCategory,
                      tvShowsList: tvShowsList,
                      tvShowId: widget.id,
                    )));
  }

  Widget _buildTextRowForRecommendedOrSimilarTvShows(
      _CategoryItems item, TvShowsList tvShowsList) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              if (item == _CategoryItems.recommended) {
                _navigateToSeeAllSimilarOrRecommendedTvShows(
                    TvShowsCategories.DetailsRecommended, tvShowsList);
              } else if (item == _CategoryItems.similar) {
                _navigateToSeeAllSimilarOrRecommendedTvShows(
                    TvShowsCategories.DetailsSimilar, tvShowsList);
              }
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

  void _navigateToCelebrityDetails(int id, String name) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: name,
                      previousPageTitle: _currentPageTitle,
                    ))
            : MaterialPageRoute(
                builder: (context) => CelebritiesDetails(
                      id: id,
                      celebName: name,
                      previousPageTitle: _currentPageTitle,
                    )));
  }

  void _navigateToSeeAllSeasons(
      String episodeImagePlaceHolder, List<Season> seasons) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeeAllSeasons(
                      previousPageTitle: _currentPageTitle,
                      tvShowId: widget.id,
                      episodeImagePlaceHolder: episodeImagePlaceHolder,
                      seasons: seasons,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeeAllSeasons(
                      previousPageTitle: _currentPageTitle,
                      tvShowId: widget.id,
                      episodeImagePlaceHolder: episodeImagePlaceHolder,
                      seasons: seasons,
                    )));
  }

  Widget _buildTextRowForSeasons(_CategoryItems item,
      String episodeImagePlaceHolder, List<Season> seasons) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllSeasons(episodeImagePlaceHolder, seasons);
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

  Widget _buildSeasonsWidget(
      List<Season> seasons, String episodeImagePlaceHolder) {
    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForSeasons(
            _CategoryItems.seasons, episodeImagePlaceHolder, seasons),
        Container(
          height: 165,
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        isIOS
                            ? CupertinoPageRoute(
                                builder: (context) => SeasonDetails(
                                      id: widget.id,
                                      name: seasons[index].name,
                                      previousPageTitle: _currentPageTitle,
                                      seasonNumber: seasons[index].seasonNumber,
                                      episodeImagePlaceHolder:
                                          episodeImagePlaceHolder,
                                    ))
                            : MaterialPageRoute(
                                builder: (context) => SeasonDetails(
                                      id: widget.id,
                                      name: seasons[index].name,
                                      previousPageTitle: _currentPageTitle,
                                      seasonNumber: seasons[index].seasonNumber,
                                      episodeImagePlaceHolder:
                                          episodeImagePlaceHolder,
                                    )));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    height: 180,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 139,
                            width: 92.5,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 0.3)),
                            child: seasons[index].posterPath != null
                                ? Image.network(
                                    IMAGE_BASE_URL +
                                        PosterSizes.w185 +
                                        seasons[index].posterPath,
                                    fit: BoxFit.fill,
                                  )
                                : Container()),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            seasons[index].name,
                            style: TextStyle(
                              fontSize: 13,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemCount: seasons.length),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6, top: 10.0),
          child: Container(
            height: 0.5,
            color: Colors.grey[900],
          ),
        ),
      ],
    );
  }

  void _navigateToSeeAllCastCrew(models.Credits credits) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeeAllCastCrew(
                      previousPageTitle: widget.tvShowTitle,
                      credits: credits,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeeAllCastCrew(
                      previousPageTitle: widget.tvShowTitle,
                      credits: credits,
                    )));
  }

  Widget _buildTextRowForCastCrew(_CategoryItems item, models.Credits credits) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            _categoryName[item],
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          Spacer(),
          CupertinoButton(
            onPressed: () {
              _navigateToSeeAllCastCrew(credits);
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

  Widget _buildCastAndCrewItems(models.Credits credits) {
    List<models.Cast> cast = credits.cast;
    int length = 0;

    if (cast.length <= 15) {
      length = cast.length;
    } else {
      length = 15;
    }

    return Column(
      children: <Widget>[
        _buildTextRowForCastCrew(_CategoryItems.castAndCrew, credits),
        Container(
          height: 125,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _navigateToCelebrityDetails(
                        cast[index].id, cast[index].name);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 105,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 85,
                          height: 85,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: cast[index].profilePath == null
                                  ? Icon(
                                      CupertinoIcons.person_solid,
                                      color: Colors.grey,
                                      size: 75,
                                    )
                                  : Image.network(
                                      IMAGE_BASE_URL +
                                          ProfileSizes.w185 +
                                          cast[index].profilePath,
                                      fit: BoxFit.fitWidth,
                                    )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            cast[index].name,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            cast[index].character,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: length),
        ),
      ],
    );
  }

  _launchURL(String url) async {
    url = 'https://www.youtube.com/watch?v=' + url;
    if (isIOS) {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      } else {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  Widget _buildVideosItems(List<models.Video> videos) {
    return Column(
      children: <Widget>[
        _divider,
        _buildTextRow(_CategoryItems.videos),
        Container(
          height: 90,
          child: ListView.separated(
              padding: const EdgeInsets.only(right: 10),
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _launchURL(videos[index].key);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    height: 90,
                    width: 160,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(getThumbnail(videoId: videos[index].key)),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 31,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Colors.transparent, Colors.black],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [0.0, 0.9])),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 20,
                              margin:
                                  const EdgeInsets.only(right: 6.0, bottom: 4),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: SvgPicture.asset(
                                'assets/icons/youtube.svg',
                                width: 15,
                                height: 15,
                                color: Colors.red[900],
                                colorBlendMode: BlendMode.color,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 10,
                );
              },
              itemCount: videos.length),
        ),
      ],
    );
  }

  Widget _getSizedBoxHeight(int length) {
    double factor = 0;
    if (length == 1) {
      return SizedBox(
        height: 0,
      );
    } else {
      for (int i = 1; i <= length; i++) {
        if (i % 2 == 0) {
          factor = 2;
        } else {
          factor = 1.5;
        }
      }
    }

    double height = (length.toDouble() / factor) * 15;

    return SizedBox(
      height: height,
    );
  }

  Widget _buildInformationWidget(TvShowDetailsData tvShow) {
    List<Widget> informationTitles;
    List<Widget> informationData;

    if (tvShow.createBy != null && tvShow.createBy.isNotEmpty) {
      informationTitles = [
        _buildInformationWidgetItemTitle('Created by'),
        _getSizedBoxHeight(tvShow.createBy.length)
      ];
      informationData = [_buildCreatedByWidget(tvShow.createBy)];
    }

    if (tvShow.firstAirDate != null && tvShow.firstAirDate.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('First Air Date')
        ];
        informationData = [
          _buildInformationWidgetItemData(tvShow.firstAirDate)
        ];
      } else {
        informationTitles
            .add(_buildInformationWidgetItemTitle('First Air Date'));
        informationData
            .add(_buildInformationWidgetItemData(tvShow.firstAirDate));
      }
    }

    if (tvShow.language != null && tvShow.language.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData.isEmpty) {
        informationTitles = [_buildInformationWidgetItemTitle('Language')];
        informationData = [_buildInformationWidgetItemData(tvShow.language)];
      } else {
        informationTitles.add(_buildInformationWidgetItemTitle('Language'));
        informationData.add(_buildInformationWidgetItemData(tvShow.language));
      }
    }

    if (tvShow.countryOrigin != null && tvShow.countryOrigin.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Country of Origin'),
          _getSizedBoxHeight(tvShow.countryOrigin.length)
        ];
        informationData = [_buildCountryOfOriginWidget(tvShow.countryOrigin)];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Country of Origin'),
          _getSizedBoxHeight(tvShow.countryOrigin.length)
        ]);

        informationData.add(_buildCountryOfOriginWidget(tvShow.countryOrigin));
      }
    }

    if (tvShow.networks != null && tvShow.networks.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Networks'),
          _getSizedBoxHeight(tvShow.networks.length)
        ];
        informationData = [_buildNetworksWidget(tvShow.networks)];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Networks'),
          _getSizedBoxHeight(tvShow.networks.length)
        ]);

        informationData.add(_buildNetworksWidget(tvShow.networks));
      }
    }

    if (tvShow.productionCompanies != null &&
        tvShow.productionCompanies.isNotEmpty) {
      if (informationTitles == null ||
          informationTitles.isEmpty && informationData == null ||
          informationData.isEmpty) {
        informationTitles = [
          _buildInformationWidgetItemTitle('Production Companies'),
          _getSizedBoxHeight(tvShow.productionCompanies.length)
        ];
        informationData = [
          _buildProductionCompaniesItems(tvShow.productionCompanies)
        ];
      } else {
        informationTitles.addAll([
          _buildInformationWidgetItemTitle('Production Companies'),
          _getSizedBoxHeight(tvShow.productionCompanies.length)
        ]);

        informationData
            .add(_buildProductionCompaniesItems(tvShow.productionCompanies));
      }
    }

    if (informationTitles == null || informationTitles.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 13),
          child: Text('Information'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: informationTitles,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: informationData,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNetworksWidget(List<Network> networks) {
    List<Text> items = networks.map((network) {
      return Text(
        network.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildCountryOfOriginWidget(List<String> countryOfOrigin) {
    List<Text> items = countryOfOrigin.map((country) {
      return Text(
        country,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildCreatedByWidget(List<Creator> creators) {
    List<Text> items = creators.map((creator) {
      return Text(
        creator.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _buildInformationWidgetItemTitle(String category) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Text(
        category,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[300]),
      ),
    );
  }

  Widget _buildInformationWidgetItemData(String data) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Text(
        data,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 13, color: Colors.grey),
      ),
    );
  }

  Widget _buildProductionCompaniesItems(
      List<models.ProductionCompany> productionCompanies) {
    List<Text> items = productionCompanies.map((productionCompany) {
      return Text(
        productionCompany.name,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: items,
      ),
    );
  }

  void _navigateToTvShowDetails(int id, String title) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: title,
                      previousPageTitle: _currentPageTitle,
                    ))
            : MaterialPageRoute(
                builder: (context) => TvShowDetails(
                      id: id,
                      tvShowTitle: title,
                      previousPageTitle: _currentPageTitle,
                    )));
  }

  Widget _buildRecommendedOrSimilarTvShows(
      TvShowsList tvShowsList, _CategoryItems item) {
    final int font = 12;

    final double listViewHeight = 200;
    final double imageHeight = 139;
    final double listItemWidth = 99;

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForRecommendedOrSimilarTvShows(item, tvShowsList),
        Container(
          height: listViewHeight,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: tvShowsList.tvShows.length < 20
                ? tvShowsList.tvShows.length
                : 20,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                width: 8,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              int length = tvShowsList.tvShows.length >= 20
                  ? 19
                  : tvShowsList.tvShows.length - 1;
              return GestureDetector(
                onTap: () {
                  _navigateToTvShowDetails(tvShowsList.tvShows[index].id,
                      tvShowsList.tvShows[index].name);
                },
                child: Container(
                  margin: index == length
                      ? const EdgeInsets.only(left: 10, right: 10)
                      : const EdgeInsets.only(left: 10),
                  width: listItemWidth,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: imageHeight,
                          width: listItemWidth,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.3, color: Colors.grey),
                          ),
                          child: Image.network(
                              IMAGE_BASE_URL +
                                  PosterSizes.w185 +
                                  tvShowsList.tvShows[index].posterPath,
                              fit: BoxFit.fill)),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              tvShowsList.tvShows[index].name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: font.toDouble()),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 1),
                            child: Text(
                              getTvShowsGenres(
                                  tvShowsList.tvShows[index].genreIds),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 11),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addTvShowToWatchList(BuildContext context, bool addTvShow) async {
    if (_isSignedIn) {
      bool deleteTvShow = false;

      if (!addTvShow) {
        deleteTvShow = await _showAlertDialog('Watchlist');
      }

      if (addTvShow || deleteTvShow) {
        bool isTvShowAddedToWatchList = await addTvShowToWatchList(
            http.Client(),
            _sessionId,
            _accountId,
            widget.id,
            addTvShow);

        if (isTvShowAddedToWatchList != null) {
          _movieTvShowProvider.addTvShow(MediaTMDbData(
              id: widget.id,
              isAddedToFavorite: _isTvShowFavourite,
              isRated: _isTvShowRated,
              rating: _rating,
              isAddedToWatchList: isTvShowAddedToWatchList));
        } else {
          showInternetConnectionFailureError(context);
        }
      }
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  void _navigateToRate(BuildContext context) {
    if (_isSignedIn) {
      Navigator.of(context).push(isIOS
          ? CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => Rate(
                    mediaId: widget.id,
                    titleOrName: _tvShowDetailsData.name,
                    posterPath: _tvShowDetailsData.posterPath,
                    backdropPath: _tvShowDetailsData.backdropPath,
                    rating: _rating,
                    ratingCategory: RatingCategory.TvShow,
                  ))
          : MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => Rate(
                    mediaId: widget.id,
                    titleOrName: _tvShowDetailsData.name,
                    posterPath: _tvShowDetailsData.posterPath,
                    backdropPath: _tvShowDetailsData.backdropPath,
                    rating: _rating,
                    ratingCategory: RatingCategory.TvShow,
                  )));
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  void _markTvShowFavourite(
      BuildContext context, bool markTvShowFavourite) async {
    if (_isSignedIn) {
      bool deleteTvShow = false;

      if (!markTvShowFavourite) {
        deleteTvShow = await _showAlertDialog('Favourite');
      }
      if (markTvShowFavourite || deleteTvShow) {
        bool isTvShowFavourite = await markTvShowAsFavourite(
            http.Client(),
            widget.id.toString(),
            _accountId,
            _sessionId,
            markTvShowFavourite);
        if (isTvShowFavourite != null) {
          _movieTvShowProvider.addTvShow(MediaTMDbData(
              id: widget.id,
              isAddedToFavorite: isTvShowFavourite,
              isRated: _isTvShowRated,
              rating: _rating,
              isAddedToWatchList: _isTvShowAddedToWatchList));
        } else {
          showInternetConnectionFailureError(context);
        }
      }
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  Future<bool> _showAlertDialog(String category) async {
    bool yes = false;

    isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text(
                    'Are you sure you want to remove it from $category ? '),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                content: Text(
                    'Are you sure you want to remove it from $category ? '),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });

    return yes;
  }

  void _checkTMDbData() async {
    _firstTimeLoaded = false;
    await _checkTvShowIsFavourite();
    await _checkMovieIsRated();
    await _checkTvShowIsAddedToWatchList();
    if (_isTvShowFavourite || _isTvShowRated || _isTvShowAddedToWatchList) {
      _movieTvShowProvider.addTvShow(MediaTMDbData(
          id: widget.id,
          isAddedToFavorite: _isTvShowFavourite,
          isRated: _isTvShowRated,
          rating: _rating,
          isAddedToWatchList: _isTvShowAddedToWatchList));
    }
    setState(() {
      _isTMDbDataLoaded = true;
    });
  }

  bool _firstTimeLoaded = true;

  MovieTvShowProvider _movieTvShowProvider;

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);

    _sessionId = loginInfoProvider.sessionId;
    _accountId = loginInfoProvider.accountId;
    if (_firstTimeLoaded ||
        ((loginInfoProvider.isSignedIn != _isSignedIn) &&
            (loginInfoProvider.isSignedIn))) {
      _checkTMDbData();
    }
    _isSignedIn = loginInfoProvider.isSignedIn;

    _movieTvShowProvider = Provider.of<MovieTvShowProvider>(context);
    MediaTMDbData mediaTMDbData =
        _movieTvShowProvider.getTvShowTMDbData(widget.id);
    if (mediaTMDbData != null) {
      _isTvShowFavourite = mediaTMDbData.isAddedToFavorite;
      _isTvShowRated = mediaTMDbData.isRated;
      _rating = mediaTMDbData.rating == null ? 0 : mediaTMDbData.rating;
      _isTvShowAddedToWatchList = mediaTMDbData.isAddedToWatchList;
    } else if (!_isSignedIn) {
      _isTvShowFavourite = false;
      _isTvShowRated = false;
      _rating = 0;
      _isTvShowAddedToWatchList = false;
    }

    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.tvShowTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: _isTvShowDataLoaded && _isInternet
                    ? <Widget>[
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isTvShowFavourite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _markTvShowFavourite(
                                      context, !_isTvShowFavourite);
                                },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isTvShowRated
                              ? Icons.star
                              : Icons.star_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _navigateToRate(context);
                                },
                        ),
                        CupertinoButton(
                          padding: const EdgeInsets.all(0),
                          child: Icon(_isSignedIn && _isTvShowAddedToWatchList
                              ? Icons.bookmark
                              : Icons.bookmark_border),
                          onPressed: !_isTMDbDataLoaded
                              ? null
                              : () {
                                  _addTvShowToWatchList(
                                      context, !_isTvShowAddedToWatchList);
                                },
                        ),
                      ]
                    : <Widget>[],
              ),
            ),
            child: _isTvShowDataLoaded
                ? _isInternet
                    ? _buildTvShowDetailsWidget(_tvShowDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeTvShowDetails,
                      )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ))
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.tvShowTitle),
              actions: _isTvShowDataLoaded && _isInternet
                  ? <Widget>[
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isTvShowFavourite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _markTvShowFavourite(
                                    context, !_isTvShowFavourite);
                              },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isTvShowRated
                            ? Icons.star
                            : Icons.star_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _navigateToRate(context);
                              },
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(_isSignedIn && _isTvShowAddedToWatchList
                            ? Icons.bookmark
                            : Icons.bookmark_border),
                        color: Colors.blue,
                        onPressed: !_isTMDbDataLoaded
                            ? null
                            : () {
                                _addTvShowToWatchList(
                                    context, !_isTvShowAddedToWatchList);
                              },
                      )
                    ]
                  : <Widget>[],
            ),
            body: _isTvShowDataLoaded
                ? _isInternet
                    ? _buildTvShowDetailsWidget(_tvShowDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeTvShowDetails,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
