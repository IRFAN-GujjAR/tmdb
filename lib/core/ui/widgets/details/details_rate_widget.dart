import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/widgets/custom_icon_button_widget.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';

import '../../../../features/media_state/presentation/blocs/media_state_state.dart';
import '../../../../features/media_state/sub_features/media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import '../../../../features/media_state/sub_features/media_tmdb/rate/presentation/pages/extra/rate_page_extra.dart';
import '../../../router/routes/app_router_paths.dart';
import '../../dialogs/dialogs_utils.dart';
import '../../utils.dart';

final class DetailsRateWidget extends StatelessWidget {
  final MediaType mediaType;
  final MediaStateState mediaState;
  final String title;
  final String? posterPath;
  final String? backdropPath;
  const DetailsRateWidget({
    super.key,
    required this.mediaType,
    required this.mediaState,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
  });

  void _onRateClick(BuildContext context, UserSessionProvider provider) {
    if (provider.isLoggedIn) {
      final mediaStateEntity = (mediaState as MediaStateStateLoaded).mediaState;
      appRouterConfig.push(
        context,
        location: AppRouterPaths.RATE,
        extra: RatePageExtra(
          mediaId: mediaStateEntity.id,
          titleOrName: title,
          posterPath: posterPath,
          backdropPath: backdropPath,
          rating: mediaStateEntity.rated.value.toInt(),
          isRated: mediaStateEntity.isRated,
          mediaType: mediaType,
          mediaStateChangesBloc: context.read<MediaStateChangesBloc>(),
        ),
      );
    } else {
      DialogUtils.showMessageDialog(
        context,
        'You are not signed in. Please Sign into your TMDb acount.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userSessionProvider = context.read<UserSessionProvider>();
    final showStarFilledIcon =
        userSessionProvider.isLoggedIn &&
        mediaState is MediaStateStateLoaded &&
        (mediaState as MediaStateStateLoaded).mediaState.isRated;
    final isEnable =
        (mediaState is MediaStateStateLoaded) ||
        !userSessionProvider.isLoggedIn;
    return CustomIconButtonWidget(
      icon: showStarFilledIcon ? Icons.star : Icons.star_border,
      onPressed: () {
        _onRateClick(context, userSessionProvider);
      },
      enable: isEnable,
    );
  }
}
