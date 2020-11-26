import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/season_details/season_details_bloc.dart';
import 'package:tmdb/bloc/home/tv_shows/details/season_details/season_details_events.dart';
import 'package:tmdb/bloc/home/tv_shows/details/season_details/season_details_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/season_details_data.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/repositories/home/tv_shows/tv_show_details/season_details/season_details_repo.dart';
import 'package:tmdb/ui/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:tmdb/utils/widgets/loading_widget.dart';

enum _RatingCategory { Season, Episode }

class SeasonDetails extends StatefulWidget {
  final int id;
  final String name;
  final String previousPageTitle;
  final int seasonNumber;
  final String episodeImagePlaceHolder;

  SeasonDetails(
      {this.id,
      this.name,
      this.previousPageTitle,
      this.seasonNumber,
      this.episodeImagePlaceHolder});

  @override
  _SeasonDetailsState createState() => _SeasonDetailsState();
}

class _SeasonDetailsState extends State<SeasonDetails> {
  SeasonDetailsBloc _seasonDetailsBloc;

  @override
  void initState() {
    _seasonDetailsBloc = SeasonDetailsBloc(
        seasonDetailsRepo: SeasonDetailsRepo(client: getHttpClient(context)));
    _initializeSeasonDetails();
    super.initState();
  }

  void _initializeSeasonDetails() {
    _seasonDetailsBloc.add(
        LoadSeasonDetails(id: widget.id, seasonNumber: widget.seasonNumber));
  }

  @override
  void dispose() {
    _seasonDetailsBloc.close();
    super.dispose();
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
    var padding = MediaQuery.of(context).padding;
    var topPadding = padding.top + kToolbarHeight + 10;
    var bottomPadding = padding.bottom + 20;

    return BlocBuilder<SeasonDetailsBloc, SeasonDetailsState>(
        cubit: _seasonDetailsBloc,
        builder: (context, seasonDetailsState) {
          if (seasonDetailsState is SeasonDetailsLoaded) {
            final seasonDetailsData = seasonDetailsState.seasonDetailsData;

            return SingleChildScrollView(
              padding: isIOS
                  ? EdgeInsets.only(
                      top: topPadding, bottom: bottomPadding, left: 12)
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
                                seasonDetailsData.posterPath,
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
                                seasonDetailsData.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4, left: 5),
                              child: Text(
                                _formatDate(seasonDetailsData.airDate),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            seasonDetailsData.episodes != null &&
                                    seasonDetailsData.episodes.isNotEmpty
                                ? _buildOverAllRatingWidget(
                                    seasonDetailsData.episodes)
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                  seasonDetailsData.overview != null &&
                          seasonDetailsData.overview.isNotEmpty
                      ? _buildOverviewWidget(seasonDetailsData.overview)
                      : Container(),
                  seasonDetailsData.episodes != null &&
                          seasonDetailsData.episodes.isNotEmpty
                      ? _buildSeasonEpisodesWidget(seasonDetailsData.episodes)
                      : Container()
                ],
              ),
            );
          } else if (seasonDetailsState is SeasonDetailsLoadingError) {
            return InternetConnectionErrorWidget(
                onPressed: _initializeSeasonDetails);
          }

          return LoadingWidget();
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
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeasonDetailsWidget)
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
            ),
            body: _buildSeasonDetailsWidget);
  }
}
