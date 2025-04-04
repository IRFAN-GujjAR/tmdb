import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/repositories/watchlist_media_repo.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/use_cases/params/watchlist_media_params.dart';

final class WatchListMediaUseCase
    implements UseCase<WatchlistMediaResultEntity, WatchlistMediaParams> {
  final WatchlistMediaRepo _repo;

  WatchListMediaUseCase(this._repo);

  @override
  Future<WatchlistMediaResultEntity> call(WatchlistMediaParams params) =>
      _repo.set(
          userId: params.userId,
          sessionId: params.sessionId,
          watchlistMedia: params.watchlistMedia);
}
