import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state/media_state_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/favourite/favourite_media_states.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/watch_list/watch_list_media_states.dart';
import 'package:tmdb/bloc/home/tv_shows/details/tv_show_details_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/tv_show_details_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/tv_show_details_states.dart';
import 'package:tmdb/bloc/login/login_state/login_state_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/models/tv_shows_list.dart';
import 'package:tmdb/models/details/common.dart' as models;
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/tmdb/media_state/media_state_repo.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/favourite_media_repo.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/watch_list_media_repo.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_details/tv_show_details_repo.dart';
import 'package:tmdb/ui/bottom_navigation/celebrities/details/celebrities_details.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/Rate.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/ui/bottom_navigation/movies/details/see_all_cast_crew/see_all_cast_crew.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/details/see_all_seasons/see_all_seasons.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/season/season_details.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/see_all/see_all_tv_shows.dart';
import 'package:tmdb/utils/dialogs/dialogs_utils.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';
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
      {@required this.id,
      @required this.tvShowTitle,
      @required this.previousPageTitle});

  @override
  _TvShowDetailsState createState() => _TvShowDetailsState();
}

class _TvShowDetailsState extends State<TvShowDetails> {
  TvShowDetailsBloc _tvShowDetailsBloc;
  MediaStateBloc _mediaStateBloc;
  StreamSubscription _mediaStateChangesSubscription;
  StreamSubscription _loginStateSubscription;

  String _currentPageTitle = '';

  Map<_CategoryItems, String> _categoryName = {
    _CategoryItems.seasons: 'Seasons',
    _CategoryItems.castAndCrew: 'Cast & Crew',
    _CategoryItems.images: 'Images',
    _CategoryItems.videos: 'Videos',
    _CategoryItems.recommended: 'Recommended',
    _CategoryItems.similar: 'Similar'
  };

  @override
  void initState() {
    _tvShowDetailsBloc = TvShowDetailsBloc(
        tvShowDetailsRepo: TvShowDetailsRepo(client: getHttpClient(context)));
    _mediaStateBloc = MediaStateBloc(
        mediaStateRepo: MediaStateRepo(client: getHttpClient(context)));
    _initializeTvShowDetails();
    _checkTvShowState();
    _listenLoginStateChanges();
    _listenMediaStateChanges();
    super.initState();
  }

  void _initializeTvShowDetails() {
    _tvShowDetailsBloc.add(LoadTvShowDetails(tvId: widget.id));
  }

  void _listenLoginStateChanges() {
    _loginStateSubscription =
        BlocProvider.of<LoginStateBloc>(context).listen((state) {
      if (state is LoginStateLoggedIn) {
        _checkTvShowState();
      }
    });
  }

  void _listenMediaStateChanges() {
    _mediaStateChangesSubscription =
        BlocProvider.of<MediaStateChangesBloc>(context).listen((state) {
      if (state is MediaStateChangesTvShowChanged) {
        if (state.tvId == widget.id) _checkTvShowState();
      }
    });
  }

  void _checkTvShowState() {
    final loginInfoProvider =
        Provider.of<LoginInfoProvider>(context, listen: false);
    if (loginInfoProvider.isSignedIn) {
      _mediaStateBloc.add(LoadMediaState(
          url: URLS.tvShowStates(widget.id, loginInfoProvider.sessionId)));
    }
  }

  @override
  void dispose() {
    _tvShowDetailsBloc.close();
    _mediaStateBloc.close();
    _mediaStateChangesSubscription.cancel();
    _loginStateSubscription.cancel();
    super.dispose();
  }

  Widget _buildTvShowDetailsWidget(TvShowDetailsState tvShowDetailsState) {
    if (tvShowDetailsState is TvShowDetailsLoaded) {
      final tvShow = tvShowDetailsState.tvShowDetails;

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
                        IMAGE_BASE_URL +
                            BackDropSizes.w780 +
                            tvShow.backdropPath,
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
                      Consumer<LoginInfoProvider>(
                          builder: (context, loginInfoProvider, _) {
                        return BlocBuilder<MediaStateBloc, MediaStateState>(
                            cubit: _mediaStateBloc,
                            builder: (context, state) {
                              final mediaState = state;
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 3,
                                      child: buildRatingWidget(
                                          tvShow.voteAverage,
                                          tvShow.voteCount)),
                                  Expanded(
                                    flex: loginInfoProvider.isSignedIn &&
                                            (mediaState is MediaStateLoaded) &&
                                            mediaState.mediaState.rated
                                        ? 1
                                        : 2,
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
                                          '${tvShow.voteAverage}',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  loginInfoProvider.isSignedIn &&
                                          mediaState is MediaStateLoaded
                                      ? mediaState.mediaState.rated
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
                                                    '${mediaState.mediaState.rating}',
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container()
                                      : Container(),
                                ],
                              );
                            });
                      }),
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
                ? _buildSeasonsWidget(
                    context, tvShow.seasons, tvShow.backdropPath)
                : _divider,
            tvShow.credits != null &&
                    tvShow.credits.cast != null &&
                    tvShow.credits.cast.isNotEmpty
                ? _buildCastAndCrewItems(context, tvShow.credits)
                : Container(),
            tvShow.videos.isNotEmpty
                ? _buildVideosItems(tvShow.videos)
                : Container(),
            _buildInformationWidget(tvShow),
            tvShow.recommendedTvShows != null &&
                    tvShow.recommendedTvShows.tvShows != null &&
                    tvShow.recommendedTvShows.tvShows.isNotEmpty
                ? _buildRecommendedOrSimilarTvShows(context,
                    tvShow.recommendedTvShows, _CategoryItems.recommended)
                : Container(),
            tvShow.similarTvShows != null &&
                    tvShow.similarTvShows.tvShows != null &&
                    tvShow.similarTvShows.tvShows.isNotEmpty
                ? _buildRecommendedOrSimilarTvShows(
                    context, tvShow.similarTvShows, _CategoryItems.similar)
                : Container(),
          ],
        ),
      );
    } else if (tvShowDetailsState is TvShowDetailsLoadingError) {
      return InternetConnectionErrorWidget(onPressed: _initializeTvShowDetails);
    }

    return LoadingWidget();
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

  Widget _buildTextRowForRecommendedOrSimilarTvShows(
      BuildContext context, _CategoryItems item, TvShowsList tvShowsList) {
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
                NavigationUtils.navigate(
                    context: context,
                    page: SeeAllTvShows(
                      previousPageTitle: widget.tvShowTitle,
                      tvShowCategory: TvShowsCategories.DetailsRecommended,
                      tvShowsList: tvShowsList,
                      tvShowId: widget.id,
                    ));
              } else if (item == _CategoryItems.similar) {
                NavigationUtils.navigate(
                    context: context,
                    page: SeeAllTvShows(
                      previousPageTitle: widget.tvShowTitle,
                      tvShowCategory: TvShowsCategories.DetailsSimilar,
                      tvShowsList: tvShowsList,
                      tvShowId: widget.id,
                    ));
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

  Widget _buildTextRowForSeasons(BuildContext context, _CategoryItems item,
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
              NavigationUtils.navigate(
                  context: context,
                  page: SeeAllSeasons(
                    previousPageTitle: _currentPageTitle,
                    tvShowId: widget.id,
                    episodeImagePlaceHolder: episodeImagePlaceHolder,
                    seasons: seasons,
                  ));
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

  Widget _buildSeasonsWidget(BuildContext context, List<Season> seasons,
      String episodeImagePlaceHolder) {
    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForSeasons(
            context, _CategoryItems.seasons, episodeImagePlaceHolder, seasons),
        Container(
          height: 165,
          child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils.navigate(
                        context: context,
                        page: SeasonDetails(
                          id: widget.id,
                          name: seasons[index].name,
                          previousPageTitle: _currentPageTitle,
                          seasonNumber: seasons[index].seasonNumber,
                          episodeImagePlaceHolder: episodeImagePlaceHolder,
                        ));
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

  Widget _buildTextRowForCastCrew(
      BuildContext context, _CategoryItems item, models.Credits credits) {
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
              NavigationUtils.navigate(
                  context: context,
                  page: SeeAllCastCrew(
                    previousPageTitle: widget.tvShowTitle,
                    credits: credits,
                  ));
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

  Widget _buildCastAndCrewItems(BuildContext context, models.Credits credits) {
    List<models.Cast> cast = credits.cast;
    int length = 0;

    if (cast.length <= 15) {
      length = cast.length;
    } else {
      length = 15;
    }

    return Column(
      children: <Widget>[
        _buildTextRowForCastCrew(context, _CategoryItems.castAndCrew, credits),
        Container(
          height: 125,
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils.navigate(
                        context: context,
                        page: CelebritiesDetails(
                          id: cast[index].id,
                          celebName: cast[index].name,
                          previousPageTitle: _currentPageTitle,
                        ));
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

  Widget _buildRecommendedOrSimilarTvShows(
      BuildContext context, TvShowsList tvShowsList, _CategoryItems item) {
    final int font = 12;

    final double listViewHeight = 200;
    final double imageHeight = 139;
    final double listItemWidth = 99;

    return Column(
      children: <Widget>[
        _divider,
        _buildTextRowForRecommendedOrSimilarTvShows(context, item, tvShowsList),
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
                  NavigationUtils.navigate(
                      context: context,
                      page: TvShowDetails(
                        id: tvShowsList.tvShows[index].id,
                        tvShowTitle: tvShowsList.tvShows[index].name,
                        previousPageTitle: _currentPageTitle,
                      ));
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

  void onFavouriteClick(BuildContext context,
      LoginInfoProvider loginInfoProvider, MediaStateState mediaState) async {
    if (loginInfoProvider.isSignedIn) {
      if (mediaState is MediaStateLoaded) {
        final isFavourite = (mediaState).mediaState.favorite;
        if (isFavourite) {
          if (!await DialogUtils.showAlertDialog(
              context, 'Are you sure you want to remove it from favourite ?'))
            return;
        }
        var event;
        if (isFavourite)
          event = UnMarkFavouriteMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        else
          event = MarkFavouriteMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        context.read<FavouriteMediaBloc>().add(event);
      }
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void _onBookMarkClick(BuildContext context,
      LoginInfoProvider loginInfoProvider, MediaStateState mediaState) async {
    if (loginInfoProvider.isSignedIn) {
      if (mediaState is MediaStateLoaded) {
        final isWatchList = (mediaState).mediaState.watchlist;
        if (isWatchList) {
          if (!await DialogUtils.showAlertDialog(
              context, 'Are you sure you want to remove it from watchlist ?'))
            return;
        }
        var event;
        if (isWatchList)
          event = RemoveWatchListMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        else
          event = AddWatchListMedia(
              user: loginInfoProvider.user, mediaId: widget.id);
        context.read<WatchListMediaBloc>().add(event);
      }
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void _onRateClick(LoginInfoProvider loginInfoProvider) {
    if (loginInfoProvider.isSignedIn) {
      final tvShowDetails =
          (_tvShowDetailsBloc.state as TvShowDetailsLoaded).tvShowDetails;
      final mediaState = (_mediaStateBloc.state as MediaStateLoaded).mediaState;
      NavigationUtils.navigate(
          context: context,
          page: Rate(
            mediaId: widget.id,
            titleOrName: tvShowDetails.name,
            posterPath: tvShowDetails.posterPath,
            backdropPath: tvShowDetails.backdropPath,
            rating: mediaState.rating.toInt(),
            isRated: mediaState.rated,
            mediaType: MediaType.TvShow,
          ),
          rootNavigator: true);
    } else {
      DialogUtils.showMessageDialog(
          context, 'You are not signed in. Please Sign into your TMDb acount.');
    }
  }

  void get _notifyTvShowStateChanges {
    context
        .read<MediaStateChangesBloc>()
        .add(NotifyTvShowMediaStateChanges(tvId: widget.id));
  }

  List<Widget> get _buildMenuItems {
    final loginInfoProvider = Provider.of<LoginInfoProvider>(context);

    return <Widget>[
      BlocProvider<FavouriteMediaBloc>(
        create: (_) => FavouriteMediaBloc(
            favouriteMediaRepo: FavouriteMediaRepo(
                client: getHttpClient(context), mediaType: MediaType.TvShow)),
        child: BlocConsumer<FavouriteMediaBloc, FavouriteMediaState>(
            listener: (context, favouriteMediaState) {
          if (favouriteMediaState is FavouriteMediaMarked) {
            _notifyTvShowStateChanges;
          } else if (favouriteMediaState is FavouriteMediaUnMarked) {
            _notifyTvShowStateChanges;
          } else if (favouriteMediaState is FavouriteMediaError) {
            DialogUtils.showMessageDialog(
                context, favouriteMediaState.error.toString());
          }
        }, builder: (context, favouriteMediaState) {
          return BlocBuilder<MediaStateBloc, MediaStateState>(
              cubit: _mediaStateBloc,
              builder: (context, mediaState) {
                final isEnable = (!(mediaState is MediaStateLoading) &&
                        !(favouriteMediaState is FavouriteMediaLoading)) ||
                    (!loginInfoProvider.isSignedIn);
                final showFavouriteFilledIcon = loginInfoProvider.isSignedIn &&
                    mediaState is MediaStateLoaded &&
                    mediaState.mediaState.favorite;

                return isIOS
                    ? CupertinoButton(
                        padding: const EdgeInsets.all(0),
                        child: Icon(showFavouriteFilledIcon
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: isEnable
                            ? () {
                                onFavouriteClick(
                                    context, loginInfoProvider, mediaState);
                              }
                            : null,
                      )
                    : IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(showFavouriteFilledIcon
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.blue,
                        onPressed: isEnable
                            ? () {
                                onFavouriteClick(
                                    context, loginInfoProvider, mediaState);
                              }
                            : null,
                      );
              });
        }),
      ),
      BlocBuilder<MediaStateBloc, MediaStateState>(
          cubit: _mediaStateBloc,
          builder: (context, mediaState) {
            final showStarFilledIcon = loginInfoProvider.isSignedIn &&
                mediaState is MediaStateLoaded &&
                mediaState.mediaState.rated;
            final isEnable = !(mediaState is MediaStateLoading) ||
                !loginInfoProvider.isSignedIn;
            return isIOS
                ? CupertinoButton(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                        showStarFilledIcon ? Icons.star : Icons.star_border),
                    onPressed: isEnable
                        ? () {
                            _onRateClick(loginInfoProvider);
                          }
                        : null,
                  )
                : IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: Icon(
                        showStarFilledIcon ? Icons.star : Icons.star_border),
                    color: Colors.blue,
                    onPressed: isEnable
                        ? () {
                            _onRateClick(loginInfoProvider);
                          }
                        : null,
                  );
          }),
      BlocProvider<WatchListMediaBloc>(
        create: (_) => WatchListMediaBloc(
            watchListMediaRepo: WatchListMediaRepo(
                client: getHttpClient(context), mediaType: MediaType.TvShow)),
        child: BlocConsumer<WatchListMediaBloc, WatchListMediaState>(
            listener: (context, watchListMediaState) {
              if (watchListMediaState is WatchListMediaAdded) {
                _notifyTvShowStateChanges;
              } else if (watchListMediaState is WatchListMediaRemoved) {
                _notifyTvShowStateChanges;
              } else if (watchListMediaState is WatchListMediaError) {
                DialogUtils.showMessageDialog(
                    context, watchListMediaState.error.toString());
              }
            },
            builder: (context, watchListMediaState) =>
                BlocBuilder<MediaStateBloc, MediaStateState>(
                  cubit: _mediaStateBloc,
                  builder: (context, mediaState) {
                    final isEnable = (!(mediaState is MediaStateLoading) &&
                            !(watchListMediaState is WatchListMediaLoading)) ||
                        (!loginInfoProvider.isSignedIn);
                    final showbookMarkFilledIcon =
                        loginInfoProvider.isSignedIn &&
                            mediaState is MediaStateLoaded &&
                            mediaState.mediaState.watchlist;

                    return isIOS
                        ? CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: Icon(showbookMarkFilledIcon
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            onPressed: isEnable
                                ? () {
                                    _onBookMarkClick(
                                        context, loginInfoProvider, mediaState);
                                  }
                                : null,
                          )
                        : IconButton(
                            padding: const EdgeInsets.all(0),
                            icon: Icon(showbookMarkFilledIcon
                                ? Icons.bookmark
                                : Icons.bookmark_border),
                            color: Colors.blue,
                            onPressed: isEnable
                                ? () {
                                    _onBookMarkClick(
                                        context, loginInfoProvider, mediaState);
                                  }
                                : null,
                          );
                  },
                )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      cubit: _tvShowDetailsBloc,
      builder: (context, tvShowDetailsState) {
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
                    trailing: BlocBuilder<MediaStateBloc, MediaStateState>(
                      cubit: _mediaStateBloc,
                      builder: (context, mediaState) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: tvShowDetailsState is TvShowDetailsLoaded
                              ? _buildMenuItems
                              : <Widget>[],
                        );
                      },
                    )),
                child: _buildTvShowDetailsWidget(tvShowDetailsState))
            : Scaffold(
                appBar: AppBar(
                  title: Text(widget.tvShowTitle),
                  actions: tvShowDetailsState is TvShowDetailsLoaded
                      ? _buildMenuItems
                      : <Widget>[],
                ),
                body: _buildTvShowDetailsWidget(tvShowDetailsState));
      },
    );
  }
}
