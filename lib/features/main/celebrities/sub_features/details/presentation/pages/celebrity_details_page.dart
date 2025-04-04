import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_error_widget.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/ui/widgets/list/media_items_horizontal_widget.dart';
import 'package:tmdb/core/ui/widgets/list/params/media_items_horizontal_params.dart';
import 'package:tmdb/core/ui/widgets/share_pop_menu_button_widget.dart';
import 'package:tmdb/core/ui/widgets/text_row_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/movie_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/domain/entities/tv_show_credits_entity.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/blocs/celebrity_details_event.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/extra/celebrity_details_page_extra.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/presentation/pages/photo/extra/celebrity_photo_page_extra.dart';

import '../../../../../../../core/entities/movie/movie_entity.dart';
import '../../../../../../../core/entities/tv_show/tv_show_entity.dart';
import '../../../../../../../core/ui/screen_utils.dart';
import '../../../../../../../core/ui/widgets/divider_widget.dart';
import '../../../../../../../core/ui/widgets/list/params/config/media_items_horizontal_config.dart';
import '../../../../../../../core/ui/widgets/loading_widget.dart';
import '../blocs/celebrity_details_bloc.dart';
import '../blocs/celebrity_details_state.dart';

class CelebrityDetailsPage extends StatelessWidget {
  final CelebrityDetailsPageExtra _extra;

  CelebrityDetailsPage(this._extra, {super.key});

  Widget get _divider {
    return DividerWidget(topPadding: 15);
  }

  Widget _buildTvShowsWidget(
    BuildContext context,
    TvShowCreditsEntity tvCredits,
  ) {
    if ((tvCredits.cast.isEmpty) && (tvCredits.crew.isEmpty)) {
      return Container();
    }

    List<TvShowEntity> tvShows;

    if (tvCredits.cast.isEmpty) {
      tvShows = tvCredits.crew;
    } else {
      tvShows = tvCredits.cast;
    }

    return Column(
      children: <Widget>[
        _divider,
        TextRowWidget(
          categoryName: 'Tv Shows',
          showSeeAllBtn: true,
          onPressed: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.SEE_ALL_TV_CREDITS_LOCATION,
              extra: tvCredits,
            );
          },
        ),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromTvShows(
            tvShows: tvShows,
            previousPageTitle: _extra.celebName,
            isLandscape: false,
            config: MediaItemsHorizontalConfig.fromDefault(),
          ),
        ),
      ],
    );
  }

  Widget _buildMoviesWidget(
    BuildContext context,
    MovieCreditsEntity movieCredits,
  ) {
    if ((movieCredits.cast.isEmpty) && (movieCredits.crew.isEmpty)) {
      return Container();
    }

    List<MovieEntity> movies;

    if (movieCredits.cast.isEmpty) {
      movies = movieCredits.crew;
    } else {
      movies = movieCredits.cast;
    }

    return Column(
      children: <Widget>[
        _divider,
        TextRowWidget(
          categoryName: 'Movies',
          showSeeAllBtn: true,
          onPressed: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.SEE_ALL_MOVIE_CREDITS_LOCATION,
              extra: movieCredits,
            );
          },
        ),
        MediaItemsHorizontalWidget(
          params: MediaItemsHorizontalParams.fromMovies(
            movies: movies,
            previousPageTitle: _extra.celebName,
            isLandscape: false,
            config: MediaItemsHorizontalConfig.fromDefault(),
          ),
        ),
      ],
    );
  }

  Widget _buildBiographyWidget(String overview) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _divider,
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 15.0),
          child: Text(
            'Biography',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 10, right: 12),
          child: Text(
            overview,
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: TextStyle(fontSize: 11)),
          Container(
            width: 220,
            child: Text(
              data,
              style: TextStyle(fontSize: 16, color: Colors.grey),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCelebrityDetailsWidget(
    BuildContext context,
    CelebrityDetailsState state,
  ) {
    if (state is CelebrityDetailsStateLoaded) {
      final celebrity = state.celebrityDetails;

      return SingleChildScrollView(
        padding: EdgeInsets.only(
          top: PagePadding.topPadding,
          bottom: PagePadding.bottomPadding,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: PagePadding.leftPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (celebrity.profilePath != null)
                        appRouterConfig.push(
                          context,
                          location: AppRouterPaths.CELEBRITY_PHOTO,
                          extra: CelebrityPhotoPageExtra(
                            name: celebrity.name,
                            photo: celebrity.profilePath!,
                          ),
                        );
                    },
                    child: CustomNetworkImageWidget(
                      imageUrl:
                          celebrity.profilePath != null
                              ? URLS.profileImageUrl(
                                imageUrl: celebrity.profilePath!,
                                size: ProfileSizes.w185,
                              )
                              : null,
                      type: MediaImageType.Celebrity,
                      width: 130,
                      height: 194,
                      fit: BoxFit.fitWidth,
                      borderRadius: 8,
                      placeHolderSize: 50,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            celebrity.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          celebrity.department != null &&
                                  celebrity.department!.isNotEmpty
                              ? _buildDescriptionWidget(
                                'known for',
                                celebrity.department!,
                              )
                              : Container(),
                          celebrity.birthPlace != null &&
                                  celebrity.birthPlace!.isNotEmpty
                              ? _buildDescriptionWidget(
                                'Birthplace',
                                celebrity.birthPlace!,
                              )
                              : Container(),
                          celebrity.birthday != null &&
                                  celebrity.birthday!.isNotEmpty
                              ? _buildDescriptionWidget(
                                'Date of Birth',
                                celebrity.birthday!,
                              )
                              : Container(),
                          celebrity.deathDay != null &&
                                  celebrity.deathDay!.isNotEmpty
                              ? _buildDescriptionWidget(
                                'Death day',
                                celebrity.deathDay!,
                              )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            celebrity.biography != null && celebrity.biography!.isNotEmpty
                ? _buildBiographyWidget(celebrity.biography!)
                : Container(),
            celebrity.movieCredits != null
                ? _buildMoviesWidget(context, celebrity.movieCredits!)
                : Container(),
            celebrity.tvCredits != null
                ? _buildTvShowsWidget(context, celebrity.tvCredits!)
                : Container(),
          ],
        ),
      );
    } else if (state is CelebrityDetailsStateError) {
      return CustomErrorWidget(
        error: state.error,
        onPressed:
            () => context.read<CelebrityDetailsBloc>().add(
              CelebrityDetailsEventLoad(_extra.id),
            ),
      );
    }

    return LoadingWidget();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CelebrityDetailsBloc, CelebrityDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_extra.celebName),
            actions:
                state is CelebrityDetailsStateLoaded
                    ? <Widget>[
                      SharePopMenuButtonWidget(
                        url: URLS.celebrityShareUrl(
                          celebId: _extra.id,
                          celebName: _extra.celebName,
                        ),
                      ),
                    ]
                    : <Widget>[],
          ),
          body: CustomBodyWidget(
            child: _buildCelebrityDetailsWidget(context, state),
          ),
        );
      },
    );
  }
}
