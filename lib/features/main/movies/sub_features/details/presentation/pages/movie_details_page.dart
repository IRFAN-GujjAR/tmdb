import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/common/collection_entity.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/login/presentation/blocs/login_status/login_status_bloc.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/pages/extra/movie_details_page_extra.dart';
import 'package:tmdb/features/main/movies/sub_features/details/presentation/widgets/movie_details_information_widget.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/presentation/pages/extra/movie_collection_details_page_extra.dart';
import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params_data.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_event.dart';
import 'package:tmdb/features/media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';

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
import '../../../../../../../core/ui/widgets/movies_category_widget.dart';
import '../../../../../../media_state/presentation/blocs/media_state_bloc.dart';
import '../../../../../../media_state/presentation/blocs/media_state_state.dart';
import '../blocs/movie_details_bloc.dart';

part '../widgets/movie_details_collection_widget.dart';

final class MovieDetailsPage extends StatelessWidget {
  final MovieDetailsPageExtra _extra;

  const MovieDetailsPage(this._extra);

  void _checkMovieState(BuildContext context) {
    final provider = context.read<UserSessionProvider>();
    if (provider.isLoggedIn)
      context.read<MediaStateBloc>().add(
        MediaStateEventLoad(
          MediaStateCFParamsData(
            type: TMDbMediaStateTypeCFCategory.movie,
            sessionId: provider.userSession.sessionId,
            mediaId: _extra.id,
          ),
        ),
      );
  }

  Widget _buildMovieDetailsWidget(
    BuildContext context,
    MovieDetailsState state,
    MovieDetailsPageExtra extra,
  ) {
    switch (state) {
      case MovieDetailsStateInitial():
      case MovieDetailsStateLoading():
        return LoadingWidget();
      case MovieDetailsStateLoaded():
        final movie = state.movieDetails;
        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: PagePadding.bottomPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  DetailsBackdropWidget(
                    mediaType: MediaType.Movie,
                    backdropDetailsPath: movie.backdropPath,
                    backdropPath: extra.backdropPath,
                  ),
                  const DetailsBackdropTransparencyWidget(),
                  DetailsPosterWidget(
                    mediaType: MediaType.Movie,
                    posterDetailsPath: movie.posterPath,
                    posterPath: extra.posterPath,
                  ),
                  DetailsMainInformationWidget(
                    title: movie.title,
                    voteAverage: movie.voteAverage,
                    voteCount: movie.voteCount,
                    genres: movie.genres,
                    overview: movie.overview,
                  ),
                ],
              ),
              if (movie.collection != null)
                MovieDetailsCollectionWidget(
                  collection: movie.collection!,
                  genres: movie.genres,
                  posterPath: movie.posterPath,
                  backdropPath: movie.backdropPath,
                ),
              if (movie.credits != null && movie.credits!.cast.isNotEmpty)
                DetailsCastAndCrewItemsWidget(
                  credits: movie.credits!,
                  previousPageTitle: movie.title,
                ),
              if (movie.videos.isNotEmpty)
                YoutubeVideosWidget(videos: movie.videos),
              (movie.releaseDate == null &&
                      movie.language == null &&
                      movie.budget == '0' &&
                      movie.revenue == '0' &&
                      movie.productionCompanies.isEmpty)
                  ? Container()
                  : MovieDetailsInformationWidget(
                    releaseDate: movie.releaseDate,
                    language: movie.language,
                    budget: movie.budget,
                    revenue: movie.revenue,
                    productionCompanies: movie.productionCompanies,
                  ),
              if (movie.recommendedMovies != null &&
                  movie.recommendedMovies!.movies.isNotEmpty)
                MoviesCategoriesWidget(
                  category: MoviesCategories.DetailsRecommended,
                  moviesList: movie.recommendedMovies!,
                  movieId: _extra.id,
                ),
              if (movie.similarMovies != null &&
                  movie.similarMovies!.movies.isNotEmpty)
                MoviesCategoriesWidget(
                  category: MoviesCategories.DetailsSimilar,
                  moviesList: movie.similarMovies!,
                  movieId: _extra.id,
                ),
            ],
          ),
        );
      case MovieDetailsStateError():
        return CustomErrorWidget(
          error: state.error,
          onPressed:
              () => context.read<MovieDetailsBloc>().add(
                MovieDetailsEventLoad(extra.id),
              ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginStatusBloc, LoginStatusState>(
          listener: (context, state) {
            if (state is LoginStatusStateLoggedIn) {
              _checkMovieState(context);
            }
          },
        ),
        BlocListener<MediaStateChangesBloc, MediaStateChangesState>(
          listener: (context, state) {
            if (state is MediaStateChangesMovieChanged) {
              if (state.movieId == _extra.id) _checkMovieState(context);
            }
          },
        ),
      ],
      child: BlocConsumer<MovieDetailsBloc, MovieDetailsState>(
        listener: (context, state) {
          if (state is MovieDetailsStateLoaded) {
            _checkMovieState(context);
          }
        },
        builder: (context, movieDetailsState) {
          return Scaffold(
            appBar: PreferredSize(
              child: Consumer<UserSessionProvider>(
                builder: (context, provider, child) {
                  return BlocBuilder<MediaStateBloc, MediaStateState>(
                    builder:
                        (context, mediaState) => AppBar(
                          title: Text(_extra.movieTitle),
                          actions:
                              movieDetailsState is MovieDetailsStateLoaded
                                  ? mediaState is MediaStateStateError
                                      ? <Widget>[
                                        DetailsMediaStateErrorWidget(
                                          mediaType: MediaType.Movie,
                                          mediaId: _extra.id,
                                        ),
                                      ]
                                      : DetailsMenuItemsWidget(
                                        mediaId: _extra.id,
                                        mediaType: MediaType.Movie,
                                        mediaState: mediaState,
                                        title: _extra.movieTitle,
                                        posterPath:
                                            movieDetailsState
                                                .movieDetails
                                                .posterPath,
                                        backdropPath:
                                            movieDetailsState
                                                .movieDetails
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
              child: _buildMovieDetailsWidget(
                context,
                movieDetailsState,
                _extra,
              ),
            ),
          );
        },
      ),
    );
  }
}
