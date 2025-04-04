import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_entity.dart';

final class WatchlistMediaParams {
  final int userId;
  final String sessionId;
  final WatchlistMediaEntity watchlistMedia;

  const WatchlistMediaParams(
      {required this.userId,
      required this.sessionId,
      required this.watchlistMedia});
}
