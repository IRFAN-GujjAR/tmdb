import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/ui/utils.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/models/rate_media_model.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_delete_rating_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_rate_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_bloc.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_event.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/presentation/blocs/rate_media_state.dart';

import '../../../../../../../core/ui/dialogs/dialogs_utils.dart';
import '../../../../../../../core/ui/initialize_app.dart';
import '../../../../media_state_changes/presentation/blocs/media_state_changes_bloc.dart';
import '../pages/extra/rate_page_extra.dart';

final class RateProvider extends ChangeNotifier {
  final RatePageExtra _extra;
  RatePageExtra get extra => _extra;

  RateProvider(this._extra) : _rating = _extra.rating;

  int _rating = 0;
  int get rating => _rating;
  set setRating(int value) {
    _rating = value;
    notifyListeners();
  }

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;
  set setShowLoadingIndicator(bool value) {
    _showLoadingIndicator = value;
    notifyListeners();
  }

  void handleState(BuildContext context, RateMediaState state) {
    if (state is RateMediaStateRated) {
      _onRatingChanged(context);
    } else if (state is RateMediaStateDeletedRating) {
      _onRatingChanged(context);
    } else if (state is RateMediaStateError) {
      DialogUtils.showMessageDialog(context, state.errorMsg);
    }
  }

  void _onRatingChanged(BuildContext context) {
    setShowLoadingIndicator = true;
    Future.delayed(Duration(seconds: 2)).whenComplete(() {
      setShowLoadingIndicator = false;
      notifyMediaStateChanges;
      appRouterConfig.pop(context);
    });
  }

  bool enable(RateMediaState state) {
    return !(state is RateMediaStateRating ||
            state is RateMediaStateDeletingRating) &&
        rating > 0 &&
        !_showLoadingIndicator;
  }

  void get notifyMediaStateChanges {
    _extra.mediaStateChangesBloc.add(
      _extra.mediaType.isMovie
          ? NotifyMovieMediaStateChanges(movieId: _extra.mediaId)
          : NotifyTvShowMediaStateChanges(tvId: _extra.mediaId),
    );
  }

  void rate(BuildContext context) {
    late RateMediaEvent event;
    final params = RateMediaRateParams(
      mediaId: _extra.mediaId,
      sessionId: context.read<UserSessionProvider>().userSession.sessionId,
      rateMedia: RateMediaModel(rating: rating),
    );
    if (_extra.mediaType.isMovie) {
      event = RateMediaEventRateMovie(params: params);
    } else {
      event = RateMediaEventRateTvShow(params: params);
    }
    context.read<RateMediaBloc>().add(event);
  }

  Future<void> deleteRating(BuildContext context) async {
    if (await DialogUtils.showAlertDialog(
      context,
      'Are you sure you want to delete the rating ?',
    )) {
      final params = RateMediaDeleteRatingParams(
        mediaId: _extra.mediaId,
        sessionId: context.read<UserSessionProvider>().userSession.sessionId,
      );
      late RateMediaEvent event;
      if (_extra.mediaType.isMovie) {
        event = RateMediaEventDeleteMovieRating(params: params);
      } else {
        event = RateMediaEventDeleteTvShowRating(params: params);
      }
      context.read<RateMediaBloc>().add(event);
    }
  }
}
