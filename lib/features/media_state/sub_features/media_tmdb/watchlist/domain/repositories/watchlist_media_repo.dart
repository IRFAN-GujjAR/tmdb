import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_result_entity.dart';

abstract class WatchlistMediaRepo {
  Future<WatchlistMediaResultEntity> set(
      {required int userId,
      required String sessionId,
      required WatchlistMediaEntity watchlistMedia});
}
