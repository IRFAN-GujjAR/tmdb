import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_delete_rating_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_rate_params.dart';

sealed class RateMediaEvent {
  const RateMediaEvent();
}

final class RateMediaEventRateMovie extends RateMediaEvent {
  final RateMediaRateParams params;

  RateMediaEventRateMovie({required this.params});
}

final class RateMediaEventRateTvShow extends RateMediaEvent {
  final RateMediaRateParams params;

  RateMediaEventRateTvShow({required this.params});
}

final class RateMediaEventDeleteMovieRating extends RateMediaEvent {
  final RateMediaDeleteRatingParams params;

  RateMediaEventDeleteMovieRating({required this.params});
}

final class RateMediaEventDeleteTvShowRating extends RateMediaEvent {
  final RateMediaDeleteRatingParams params;

  RateMediaEventDeleteTvShowRating({required this.params});
}
