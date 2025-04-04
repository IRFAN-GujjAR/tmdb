import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/presentation/pages/extra/tv_show_details_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/presentation/widgets/tv_show_details_information_widget.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/presentation/widgets/tv_show_details_season_widget.dart';
import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params_data.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_event.dart'
    show MediaStateEventLoad;

import '../../../../../../../core/ui/screen_utils.dart';
import '../../../../../../../core/ui/widgets/custom_error_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_backdrop_transparency_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_backdrop_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_cast_and_crew_items_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_divider_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_main_information_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_media_state_error_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_menu_items_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_poster_widget.dart';
import '../../../../../../../core/ui/widgets/details/details_youtube_videos_widget.dart';
import '../../../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../../../core/ui/widgets/tv_shows_category_widget.dart';
import '../../../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import '../../../../../../login/presentation/blocs/login_status/login_status_bloc.dart';
import '../../../../../../media_state/presentation/blocs/media_state_bloc.dart';
import '../../../../../../media_state/presentation/blocs/media_state_state.dart';
import '../../../../../../media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import '../blocs/tv_show_details_bloc.dart';

final class TvShowDetailsPage extends StatelessWidget {
  final TvShowDetailsPageExtra _extra;

  TvShowDetailsPage(this._extra, {super.key});

  void _checkTvShowState(BuildContext context) {
    final provider = context.read<UserSessionProvider>();
    if (provider.isLoggedIn)
      context.read<MediaStateBloc>().add(
        MediaStateEventLoad(
          MediaStateCFParamsData(
            type: TMDbMediaStateTypeCFCategory.tv,
            sessionId: provider.userSession.sessionId,
            mediaId: _extra.id,
          ),
        ),
      );
  }

  Widget _buildTvShowDetailsWidget(
    BuildContext context,
    TvShowDetailsState tvShowDetailsState,
  ) {
    if (tvShowDetailsState is TvShowDetailsStateLoaded) {
      final tvShow = tvShowDetailsState.tvShowDetails;

      return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: PagePadding.bottomPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                DetailsBackdropWidget(
                  mediaType: MediaType.TvShow,
                  backdropDetailsPath: tvShow.backdropPath,
                  backdropPath: _extra.backdropPath,
                ),
                const DetailsBackdropTransparencyWidget(),
                DetailsPosterWidget(
                  mediaType: MediaType.TvShow,
                  posterDetailsPath: tvShow.posterPath,
                  posterPath: _extra.posterPath,
                ),
                DetailsMainInformationWidget(
                  title: tvShow.name,
                  voteAverage: tvShow.voteAverage,
                  voteCount: tvShow.voteCount,
                  genres: tvShow.genres,
                  overview: tvShow.overview,
                ),
              ],
            ),
            tvShow.seasons.isNotEmpty
                ? TvShowDetailsSeasonWidget(
                  tvId: _extra.id,
                  tvShowName: tvShow.name,
                  tvShowPosterPath: tvShow.posterPath,
                  episodeImagePlaceHolder: tvShow.backdropPath,
                  seasons: tvShow.seasons,
                )
                : DetailsDividerWidget(topPadding: 15),
            if (tvShow.credits != null && tvShow.credits!.cast.isNotEmpty)
              DetailsCastAndCrewItemsWidget(
                credits: tvShow.credits!,
                previousPageTitle: tvShow.name,
              ),
            if (tvShow.videos.isNotEmpty)
              YoutubeVideosWidget(videos: tvShow.videos),
            TvShowDetailsInformationWidget(
              createdBy: tvShow.createBy,
              firstAirDate: tvShow.firstAirDate,
              language: tvShow.language,
              countryOrigin: tvShow.countryOrigin,
              networks: tvShow.networks,
              productionCompanies: tvShow.productionCompanies,
            ),
            if (tvShow.recommendedTvShows != null &&
                tvShow.recommendedTvShows!.tvShows.isNotEmpty)
              TvShowsCategoryWidget(
                category: TvShowsCategories.DetailsRecommended,
                tvShowsList: tvShow.recommendedTvShows!,
                tvId: _extra.id,
              ),
            if (tvShow.similarTvShows != null &&
                tvShow.similarTvShows!.tvShows.isNotEmpty)
              TvShowsCategoryWidget(
                category: TvShowsCategories.DetailsSimilar,
                tvShowsList: tvShow.similarTvShows!,
                tvId: _extra.id,
              ),
          ],
        ),
      );
    } else if (tvShowDetailsState is TvShowDetailsStateError) {
      return CustomErrorWidget(
        error: tvShowDetailsState.error,
        onPressed: () {
          context.read<TvShowDetailsBloc>().add(
            TvShowDetailsEventLoad(tvId: _extra.id),
          );
        },
      );
    }

    return LoadingWidget();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginStatusBloc, LoginStatusState>(
          listener: (context, state) {
            if (state is LoginStatusStateLoggedIn) {
              _checkTvShowState(context);
            }
          },
        ),
        BlocListener<MediaStateChangesBloc, MediaStateChangesState>(
          listener: (context, state) {
            if (state is MediaStateChangesTvShowChanged) {
              if (state.tvId == _extra.id) _checkTvShowState(context);
            }
          },
        ),
      ],
      child: BlocConsumer<TvShowDetailsBloc, TvShowDetailsState>(
        listener: (context, state) {
          if (state is TvShowDetailsStateLoaded) {
            _checkTvShowState(context);
          }
        },
        builder: (context, tvShowDetailsState) {
          return Scaffold(
            appBar: PreferredSize(
              child: Consumer<UserSessionProvider>(
                builder: (context, provider, child) {
                  return BlocBuilder<MediaStateBloc, MediaStateState>(
                    builder:
                        (context, mediaState) => AppBar(
                          title: Text(_extra.tvShowTitle),
                          actions:
                              tvShowDetailsState is TvShowDetailsStateLoaded
                                  ? mediaState is MediaStateStateError
                                      ? <Widget>[
                                        DetailsMediaStateErrorWidget(
                                          mediaType: MediaType.TvShow,
                                          mediaId: _extra.id,
                                        ),
                                      ]
                                      : DetailsMenuItemsWidget(
                                        mediaId: _extra.id,
                                        mediaType: MediaType.TvShow,
                                        mediaState: mediaState,
                                        title: _extra.tvShowTitle,
                                        posterPath:
                                            tvShowDetailsState
                                                .tvShowDetails
                                                .posterPath,
                                        backdropPath:
                                            tvShowDetailsState
                                                .tvShowDetails
                                                .backdropPath,
                                      ).build(context)
                                  : <Widget>[],
                        ),
                  );
                },
              ),
              preferredSize: Size.fromHeight(kToolbarHeight),
            ),
            body: SafeArea(
              child: _buildTvShowDetailsWidget(context, tvShowDetailsState),
            ),
          );
        },
      ),
    );
  }
}
