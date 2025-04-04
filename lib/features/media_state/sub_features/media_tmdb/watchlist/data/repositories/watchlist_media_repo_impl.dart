import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/data_sources/watchlist_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/models/watchlist_media_model.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/repositories/watchlist_media_repo.dart';

final class WatchlistMediaRepoImpl implements WatchlistMediaRepo {
  final WatchlistMediaDataSource _dataSource;

  WatchlistMediaRepoImpl(this._dataSource);

  @override
  Future<WatchlistMediaResultEntity> set(
          {required int userId,
          required String sessionId,
          required WatchlistMediaEntity watchlistMedia}) =>
      _dataSource.set(
          userId: userId,
          sessionId: sessionId,
          watchlistMedia: WatchlistMediaModel(
              mediaType: watchlistMedia.mediaType,
              mediaId: watchlistMedia.mediaId,
              set: watchlistMedia.set));
}
