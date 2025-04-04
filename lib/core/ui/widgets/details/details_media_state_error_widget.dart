import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params_data.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_bloc.dart';
import 'package:tmdb/features/media_state/presentation/blocs/media_state_event.dart';

final class DetailsMediaStateErrorWidget extends StatelessWidget {
  final MediaType mediaType;
  final int mediaId;

  const DetailsMediaStateErrorWidget({
    super.key,
    required this.mediaType,
    required this.mediaId,
  });

  void _checkMovieState(BuildContext context) {
    final userSessionProvider = context.read<UserSessionProvider>();
    if (userSessionProvider.isLoggedIn)
      if (userSessionProvider.isLoggedIn)
        context.read<MediaStateBloc>().add(
          MediaStateEventLoad(
            MediaStateCFParamsData(
              type:
                  mediaType == MediaType.Movie
                      ? TMDbMediaStateTypeCFCategory.movie
                      : TMDbMediaStateTypeCFCategory.tv,
              sessionId: userSessionProvider.userSession.sessionId,
              mediaId: mediaId,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: Icon(Icons.error, color: Colors.red),
      color: Colors.blue,
      onPressed: () => _checkMovieState(context),
    );
  }
}
