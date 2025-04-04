import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_state.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/use_cases/params/watchlist_media_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/presentation/blocs/watchlist_media_bloc.dart';

import '../../../../features/media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import '../../dialogs/dialogs_utils.dart';
import '../../utils.dart';

final class DetailsWatchlistWidget extends StatelessWidget {
  final MediaType mediaType;
  final MediaStateState mediaState;

  const DetailsWatchlistWidget({
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

  void _onBookMarkClick(
    BuildContext context,
    UserSessionProvider provider,
  ) async {
    if (provider.isLoggedIn) {
      if (mediaState is MediaStateStateLoaded) {
        final isWatchList =
            (mediaState as MediaStateStateLoaded).mediaState.watchlist;
        if (isWatchList) {
          if (!await DialogUtils.showAlertDialog(
            context,
            'Are you sure you want to remove it from watchlist ?',
          ))
            return;
        }
        context.read<WatchlistMediaBloc>().add(
          WatchlistMediaEvent(
            params: WatchlistMediaParams(
              userId: provider.userSession.userId,
              sessionId: provider.userSession.sessionId,
              watchlistMedia: WatchlistMediaEntity(
                mediaType: MEDIA_TYPE_VALUE[mediaType]!,
                mediaId: (mediaState as MediaStateStateLoaded).mediaState.id,
                set: !isWatchList,
              ),
            ),
          ),
        );
      }
    } else {
      DialogUtils.showMessageDialog(
        context,
        'You are not signed in. Please Sign into your TMDb acount.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistMediaBloc, WatchlistMediaState>(
      listener: (context, state) {
        if (state is WatchlistMediaStateAdded) {
          _notifyStateChanges(context);
        } else if (state is WatchlistMediaStateRemoved) {
          _notifyStateChanges(context);
        } else if (state is WatchlistMediaStateError) {
          DialogUtils.showMessageDialog(context, state.errorMsg);
        }
      },
      builder: (context, state) {
        final userSessionProvider = context.read<UserSessionProvider>();
        final isEnable =
            ((mediaState is MediaStateStateLoaded) &&
                !(state is WatchlistMediaStateAdding)) ||
            (!userSessionProvider.isLoggedIn);
        final showBookMarkFilledIcon =
            userSessionProvider.isLoggedIn &&
            mediaState is MediaStateStateLoaded &&
            (mediaState as MediaStateStateLoaded).mediaState.watchlist;
        return IconButton(
          padding: const EdgeInsets.all(0),
          icon: Icon(
            showBookMarkFilledIcon ? Icons.bookmark : Icons.bookmark_border,
          ),
          onPressed:
              isEnable
                  ? () {
                    _onBookMarkClick(context, userSessionProvider);
                  }
                  : null,
        );
      },
    );
  }
}
