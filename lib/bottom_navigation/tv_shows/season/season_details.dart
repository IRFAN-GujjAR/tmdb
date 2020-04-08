import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/season_details_data.dart';
import 'package:tmdb/network/season_details_api.dart';
import 'package:tmdb/utils/utils.dart';

enum _RatingCategory { Season, Episode }

class SeasonDetails extends StatefulWidget {
  final int id;
  final String name;
  final String previousPageTitle;
  final int seasonNumber;
  final String episodeImagePlaceHolder;

  SeasonDetails(
      {
      this.id,
      this.name,
      this.previousPageTitle,
      this.seasonNumber,
      this.episodeImagePlaceHolder});

  @override
  _SeasonDetailsState createState() => _SeasonDetailsState();
}

class _SeasonDetailsState extends State<SeasonDetails> {
  SeasonDetailsData _seasonDetailsData;
  bool _isDataLoaded = false;
  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeSeasonDetails();
      }
    });
    _initializeSeasonDetails();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  void _initializeSeasonDetails() async {
    setState(() {
      _isDataLoaded = false;
    });
    _seasonDetailsData = await getSeasonDetails(
        http.Client(), widget.id, widget.seasonNumber);
    if (_seasonDetailsData == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      _isInternet = true;
    }
    setState(() {
      _isDataLoaded = true;
    });
  }

  Widget _buildRatingWidget(
      _RatingCategory ratingCategory, double voteAverage, int voteCount) {
    List<IconData> stars;

    double rating = voteAverage / 2;
    int counter = rating.toInt();

    for (int i = 0; i < counter; i++) {
      stars == null ? stars = [Icons.star] : stars.add(Icons.star);
    }

    if (rating.toString().contains('.')) {
      if (voteCount == 0 && voteAverage == 0) {
        stars = [Icons.star_border];
      } else {
        stars == null ? stars = [Icons.star_half] : stars.add(Icons.star_half);
      }
    }
    while (stars.length < 5) {
      stars.add(Icons.star_border);
    }

    return Container(
      margin: const EdgeInsets.only(left: 4, bottom: 1),
      height: 15,
      width: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return index != 5
              ? Icon(
                  stars[index],
                  color: Colors.blue,
                  size: ratingCategory == _RatingCategory.Season ? 15 : 12,
                )
              : Padding(
                  padding: ratingCategory == _RatingCategory.Season
                      ? const EdgeInsets.only(left: 5)
                      : const EdgeInsets.only(left: 5, top: 2),
                  child: Text(
                    '( $voteCount )',
                    style: TextStyle(
                        fontSize:
                            ratingCategory == _RatingCategory.Season ? 13 : 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ));
        },
        itemCount: 6,
      ),
    );
  }

  Widget get _divider {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      height: 0.5,
      color: Colors.grey[900],
    );
  }

  Widget _buildSeasonEpisodesWidget(List<Episode> episodes) {
    int counter = 0;
    List<Widget> items = episodes.map((episode) {
      counter++;

      return Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: 107,
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3)),
                    child: episode.stillPath != null &&
                            episode.stillPath.isNotEmpty
                        ? Image.network(
                            IMAGE_BASE_URL +
                                StillSizes.w185 +
                                episode.stillPath,
                            fit: BoxFit.fitWidth,
                          )
                        : Image.network(
                            IMAGE_BASE_URL +
                                BackDropSizes.w300 +
                                widget.episodeImagePlaceHolder,
                            fit: BoxFit.fitWidth,
                          )),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 235,
                        child: Text(
                          counter.toString() + '. ' + episode.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: <Widget>[
                            episode.airDate != null &&
                                    episode.airDate.isNotEmpty
                                ? Text(
                                    _formatDate(episode.airDate),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[300],
                                        fontWeight: FontWeight.w500),
                                  )
                                : Container(),
                            _buildRatingWidget(_RatingCategory.Episode,
                                episode.voteAverage, episode.voteCount)
                          ],
                        ),
                      ),
                      episode.overview != null && episode.overview.isNotEmpty
                          ? Container(
                              width: 235,
                              margin: const EdgeInsets.only(top: 1),
                              child: Text(
                                episode.overview,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ))
                          : Container()
                    ],
                  ),
                )
              ],
            ),
            counter != episodes.length ? _divider : Container()
          ],
        ),
      );
    }).toList();

    items = [
          _divider,
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Episodes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        ] +
        items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  Widget _buildOverviewWidget(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            'About this Show',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0, right: 12),
          child: Text(
            overview,
            style: TextStyle(
                fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Widget _buildOverAllRatingWidget(List<Episode> episodes) {
    List<int> voteCounts;
    List<double> voteAverages;

    episodes.forEach((episode) {
      voteCounts == null
          ? voteCounts = [episode.voteCount]
          : voteCounts.add(episode.voteCount);
      voteAverages == null
          ? voteAverages = [episode.voteAverage]
          : voteAverages.add(episode.voteAverage);
    });

    int sumOfVoteCounts = 0;
    double sumOfVoteAverages = 0;
    double overAllVoteAverage = 0;

    if (voteAverages != null && voteAverages.isNotEmpty) {
      voteCounts.forEach((voteCount) {
        sumOfVoteCounts = sumOfVoteCounts + voteCount;
      });
      voteAverages.forEach((voteAverage) {
        sumOfVoteAverages = sumOfVoteAverages + voteAverage;
      });

      overAllVoteAverage = sumOfVoteAverages / voteAverages.length;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: _buildRatingWidget(
          _RatingCategory.Season, overAllVoteAverage, sumOfVoteCounts),
    );
  }

  String _formatDate(String date) {
    String formattedDate = '';
    for (int i = 0; i < date.length; i++) {
      if (date[i].contains(' ')) {
        formattedDate = formattedDate + '-';
      } else {
        formattedDate = formattedDate + date[i];
      }
    }
    return formattedDate;
  }

  Widget get _buildSeasonDetailsWidget {
    
    var padding=MediaQuery.of(context).padding;
    var topPadding=padding.top+kToolbarHeight+10;
    var bottomPadding=padding.bottom+20;
    
    return SingleChildScrollView(
      padding: isIOS
          ? EdgeInsets.only(top: topPadding, bottom: bottomPadding, left: 12)
          : const EdgeInsets.only(left: 12, top: 20, bottom: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 98,
                  height: 148,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.3),
                  ),
                  child: Image.network(
                    IMAGE_BASE_URL +
                        ProfileSizes.w185 +
                        _seasonDetailsData.posterPath,
                    fit: BoxFit.fitWidth,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        widget.previousPageTitle,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 5),
                      child: Text(
                        _seasonDetailsData.name,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 5),
                      child: Text(
                        _formatDate(_seasonDetailsData.airDate),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    _seasonDetailsData.episodes != null &&
                            _seasonDetailsData.episodes.isNotEmpty
                        ? _buildOverAllRatingWidget(_seasonDetailsData.episodes)
                        : Container()
                  ],
                ),
              ),
            ],
          ),
          _seasonDetailsData.overview != null &&
                  _seasonDetailsData.overview.isNotEmpty
              ? _buildOverviewWidget(_seasonDetailsData.overview)
              : Container(),
          _seasonDetailsData.episodes != null &&
                  _seasonDetailsData.episodes.isNotEmpty
              ? _buildSeasonEpisodesWidget(_seasonDetailsData.episodes)
              : Container()
        ],
      ),
    );
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
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: Container(
              child: _isDataLoaded
                  ? _isInternet
                      ? _buildSeasonDetailsWidget
                      : InternetConnectionErrorWidget(
                          onPressed: _initializeSeasonDetails,
                        )
                  : Center(
                      child: CupertinoActivityIndicator(),
                    ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
            ),
            body: Container(
              child: _isDataLoaded
                  ? _isInternet
                      ? _buildSeasonDetailsWidget
                      : InternetConnectionErrorWidget(
                          onPressed: _initializeSeasonDetails,
                        )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
  }
}
