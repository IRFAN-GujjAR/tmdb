import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/loading_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/episode_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/params/tv_show_season_details_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/blocs/tv_show_season_details_bloc.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/tv_show_season_details_page_extra.dart';

import '../../../../../../../../../core/ui/screen_utils.dart';
import '../../../../../../../../../core/ui/utils.dart';
import '../../../../../../../../../core/ui/widgets/divider_widget.dart';
import '../../../../../../../../../core/ui/widgets/rating_widget.dart';
import '../../../../../../../../../core/ui/widgets/tv_poster_placeholder_widget.dart';

enum _RatingCategory { Season, Episode }

class TvShowSeasonDetailsPage extends StatelessWidget {
  final TvShowSeasonDetailsPageExtra _extra;

  const TvShowSeasonDetailsPage(this._extra, {super.key});

  Widget _buildRatingWidget(
    _RatingCategory ratingCategory,
    double voteAverage,
    int voteCount,
  ) {
    return Container(
      width: 130,
      child: CustomRatingWidget(
        voteAverage: voteAverage,
        voteCount: voteCount,
        iconSize: ratingCategory == _RatingCategory.Season ? 15 : 12,
        fontSize: ratingCategory == _RatingCategory.Season ? 13 : 10,
        voteCountPading:
            ratingCategory == _RatingCategory.Season
                ? const EdgeInsets.only(left: 5)
                : const EdgeInsets.only(left: 5, top: 2),
        margin: const EdgeInsets.only(left: 4, bottom: 1),
      ),
    );
  }

  Widget get _divider {
    return DividerWidget(topPadding: 15.0, indent: 0);
  }

  Widget _buildSeasonEpisodesWidget(List<EpisodeEntity> episodes) {
    int counter = 0;
    List<Widget> items =
        episodes.map((episode) {
          counter++;

          String? imageUrl =
              episode.stillPath ?? _extra.episodeImagePlaceHolder;
          if (imageUrl != null) {
            if (imageUrl.isEmpty) {
              imageUrl = null;
            } else {
              imageUrl = URLS.stillImageUrl(
                imageUrl: imageUrl,
                size: StillSizes.w185,
              );
            }
          }

          return Padding(
            padding: EdgeInsets.only(
              top: 15.0,
              right: PagePadding.rightPadding,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CustomNetworkImageWidget(
                        type: MediaImageType.TvShow,
                        imageUrl: imageUrl,
                        width: 107,
                        height: 60,
                        fit: BoxFit.fill,
                        borderRadius: 0,
                        placeHolderSize: 36,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 235,
                              child: Text(
                                counter.toString() + '. ' + episode.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Row(
                                children: <Widget>[
                                  episode.airDate != null &&
                                          episode.airDate!.isNotEmpty
                                      ? Expanded(
                                        flex: 1,
                                        child: Text(
                                          episode.airDate!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[300],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                      : Container(),
                                  Expanded(
                                    flex: 1,
                                    child: _buildRatingWidget(
                                      _RatingCategory.Episode,
                                      episode.voteAverage,
                                      episode.voteCount,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            episode.overview != null &&
                                    episode.overview!.isNotEmpty
                                ? Container(
                                  margin: const EdgeInsets.only(top: 1),
                                  child: Text(
                                    episode.overview!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                counter != episodes.length ? _divider : Container(),
              ],
            ),
          );
        }).toList();

    items =
        [
          _divider,
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Text(
              'Episodes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
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
              fontSize: 13,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverAllRatingWidget(List<EpisodeEntity> episodes) {
    List<int>? voteCounts;
    List<double>? voteAverages;

    episodes.forEach((episode) {
      voteCounts == null
          ? voteCounts = [episode.voteCount]
          : voteCounts!.add(episode.voteCount);
      voteAverages == null
          ? voteAverages = [episode.voteAverage]
          : voteAverages!.add(episode.voteAverage);
    });

    int sumOfVoteCounts = 0;
    double sumOfVoteAverages = 0;
    double overAllVoteAverage = 0;

    if (voteAverages != null && voteAverages!.isNotEmpty) {
      voteCounts!.forEach((voteCount) {
        sumOfVoteCounts = sumOfVoteCounts + voteCount;
      });
      voteAverages!.forEach((voteAverage) {
        sumOfVoteAverages = sumOfVoteAverages + voteAverage;
      });

      overAllVoteAverage = sumOfVoteAverages / voteAverages!.length;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: _buildRatingWidget(
        _RatingCategory.Season,
        overAllVoteAverage,
        sumOfVoteCounts,
      ),
    );
  }

  Widget get _buildSeasonDetailsWidget {
    return BlocBuilder<TvShowSeasonDetailsBloc, TvShowSeasonDetailsState>(
      builder: (context, state) {
        switch (state) {
          case TvShowSeasonDetailsStateInitial():
          case TvShowSeasonDetailsStateLoading():
            return LoadingWidget();
          case TvShowSeasonDetailsStateLoaded():
            final seasonDetails = state.tvShowSeasonDetails;

            return SingleChildScrollView(
              padding: EdgeInsets.only(
                top: PagePadding.topPadding,
                bottom: PagePadding.bottomPadding,
                left: PagePadding.leftPadding,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          width: 98,
                          height: 148,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.3),
                          ),
                          child:
                              seasonDetails.posterPath == null &&
                                      _extra.tvShowPosterPath == null
                                  ? TvPosterPlaceholderWidget(size: 60)
                                  : Image.network(
                                    URLS.profileImageUrl(
                                      imageUrl:
                                          (seasonDetails.posterPath == null
                                              ? _extra.tvShowPosterPath!
                                              : seasonDetails.posterPath!),
                                      size: ProfileSizes.w185,
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  _extra.tvShowName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8, left: 5),
                                child: Text(
                                  seasonDetails.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4, left: 5),
                                child: Text(
                                  seasonDetails.airDate,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              seasonDetails.episodes.isNotEmpty
                                  ? Container(
                                    width: double.maxFinite,
                                    child: _buildOverAllRatingWidget(
                                      seasonDetails.episodes,
                                    ),
                                  )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  seasonDetails.overview != null &&
                          seasonDetails.overview!.isNotEmpty
                      ? _buildOverviewWidget(seasonDetails.overview!)
                      : Container(),
                  seasonDetails.episodes.isNotEmpty
                      ? _buildSeasonEpisodesWidget(seasonDetails.episodes)
                      : Container(),
                ],
              ),
            );
          case TvShowSeasonDetailsStateError():
            return CustomErrorWidget(
              error: state.error,
              onPressed: () {
                context.read<TvShowSeasonDetailsBloc>().add(
                  TvShowSeasonDetailsEventLoad(
                    TvShowSeasonDetailsParams(
                      tvId: _extra.tvId,
                      seasonNo: _extra.seasonNo,
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_extra.seasonName)),
      body: CustomBodyWidget(child: _buildSeasonDetailsWidget),
    );
  }
}
