import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/ui/widgets/share_menu_button_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/data_sources/favorite_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/repositories/favorite_media_repo_impl.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/use_cases/favorite_media_use_case.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/presentation/blocs/favorite_media_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/data_sources/watchlist_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/repositories/watchlist_media_repo_impl.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/use_cases/watchlist_media_use_case.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/presentation/blocs/watchlist_media_bloc.dart';

import '../../../../features/media_state/presentation/blocs/media_state_state.dart';
import '../../utils.dart';
import 'details_favorite_widget.dart';
import 'details_rate_widget.dart';
import 'details_watchlist_widget.dart';

final class DetailsMenuItemsWidget {
  final int mediaId;
  final MediaType mediaType;
  final MediaStateState mediaState;
  final String title;
  final String? posterPath;
  final String? backdropPath;

  const DetailsMenuItemsWidget({
    required this.mediaId,
    required this.mediaType,
    required this.mediaState,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
  });

  List<Widget> build(BuildContext context) {
    return <Widget>[
      BlocProvider<FavoriteMediaBloc>(
        create:
            (context) => FavoriteMediaBloc(
              FavoriteMediaUseCase(
                FavoriteMediaRepoImpl(
                  FavoriteMediaDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                ),
              ),
            ),
        child: DetailsFavoriteWidget(
          mediaType: mediaType,
          mediaState: mediaState,
        ),
      ),
      DetailsRateWidget(
        mediaType: mediaType,
        mediaState: mediaState,
        title: title,
        posterPath: posterPath,
        backdropPath: backdropPath,
      ),
      BlocProvider<WatchlistMediaBloc>(
        create:
            (context) => WatchlistMediaBloc(
              WatchListMediaUseCase(
                WatchlistMediaRepoImpl(
                  WatchlistMediaDataSourceImpl(CloudFunctionsUtl.tMDBFunction),
                ),
              ),
            ),
        child: DetailsWatchlistWidget(
          mediaType: mediaType,
          mediaState: mediaState,
        ),
      ),
      ShareMenuButtonWidget(
        url:
            mediaType.isMovie
                ? URLS.movieShareUrl(movieId: mediaId, title: title)
                : URLS.tvShowShareUrl(tvId: mediaId, title: title),
      ),
    ];
  }
}
