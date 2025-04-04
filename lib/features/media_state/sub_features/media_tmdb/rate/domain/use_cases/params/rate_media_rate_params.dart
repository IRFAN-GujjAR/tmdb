import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_entity.dart';

final class RateMediaRateParams {
  final int mediaId;
  final String sessionId;
  final RateMediaEntity rateMedia;

  RateMediaRateParams(
      {required this.mediaId,
      required this.sessionId,
      required this.rateMedia});
}
