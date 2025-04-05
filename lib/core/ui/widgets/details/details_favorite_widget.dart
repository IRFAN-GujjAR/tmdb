import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/core/ui/widgets/custom_icon_button_widget.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_state.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/use_cases/params/favorite_media_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/presentation/blocs/favorite_media_bloc.dart';

import '../../../../features/media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import '../../dialogs/dialogs_utils.dart';

final class DetailsFavoriteWidget extends StatelessWidget {
  final MediaType mediaType;
  final MediaStateState mediaState;

  const DetailsFavoriteWidget({
    super.key,
    required this.mediaType,
    required this.mediaState,
  });

  void _notifyStateChanges(BuildContext context) {
    final mediaId = (mediaState as MediaStateStateLoaded).mediaState.id;
    context.read<MediaStateChangesBloc>().add(
      mediaType == MediaType.Movie
          ? NotifyMovieMediaStateChanges(movieId: mediaId)
          : NotifyTvShowMediaStateChanges(tvId: mediaId),
    );
  }

  void onFavouriteClick(
    BuildContext context,
    UserSessionProvider userSessionProvider,
  ) async {
    if (userSessionProvider.isLoggedIn) {
      if (mediaState is MediaStateStateLoaded) {
        final mediaId = (mediaState as MediaStateStateLoaded).mediaState.id;
        final isFavourite =
            (mediaState as MediaStateStateLoaded).mediaState.favorite;
        if (isFavourite) {
          if (!await DialogUtils.showAlertDialog(
            context,
            'Are you sure you want to remove it from favorites ?',
          ))
            return;
        }
        context.read<FavoriteMediaBloc>().add(
          FavoriteMediaEvent(
            params: FavoriteMediaParams(
              userId: userSessionProvider.userSession.userId,
              sessionId: userSessionProvider.userSession.sessionId,
              favoriteMedia: FavoriteMediaEntity(
                mediaType: MEDIA_TYPE_VALUE[mediaType]!,
                mediaId: mediaId,
                set: !isFavourite,
              ),
            ),
          ),
        );
      }
    } else {
      DialogUtils.showMessageDialog(
        context,
        'You are not signed in. Please Sign into your TMDb account.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteMediaBloc, FavoriteMediaState>(
      listener: (context, favoriteMediaState) {
        if (favoriteMediaState is FavoriteMediaStateMarked) {
          _notifyStateChanges(context);
        } else if (favoriteMediaState is FavoriteMediaStateUnMarked) {
          _notifyStateChanges(context);
        } else if (favoriteMediaState is FavoriteMediaStateError) {
          DialogUtils.showMessageDialog(context, favoriteMediaState.errorMsg);
        }
      },
      builder: (context, favouriteMediaState) {
        final userSessionProvider = context.read<UserSessionProvider>();
        final isLoggedIn = userSessionProvider.isLoggedIn;
        final isEnable =
            ((mediaState is MediaStateStateLoaded) &&
                !(favouriteMediaState is FavoriteMediaStateMarking)) ||
            (!isLoggedIn);
        final showFavouriteFilledIcon =
            isLoggedIn &&
            mediaState is MediaStateStateLoaded &&
            (mediaState as MediaStateStateLoaded).mediaState.favorite;

        return CustomIconButtonWidget(
          icon:
              showFavouriteFilledIcon ? Icons.favorite : Icons.favorite_border,
          onPressed: () {
            onFavouriteClick(context, userSessionProvider);
          },
          enable: isEnable,
        );
      },
    );
  }
}
