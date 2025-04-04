import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/repositories/rate_media_repo.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_delete_rating_params.dart';

final class RateMediaUseCaseDeleteTvShowRating
    implements UseCase<RateMediaResultEntity, RateMediaDeleteRatingParams> {
  final RateMediaRepo _repo;

  RateMediaUseCaseDeleteTvShowRating(this._repo);

  @override
  Future<RateMediaResultEntity> call(RateMediaDeleteRatingParams params) =>
      _repo.deleteTvShowRating(
          tvShowId: params.mediaId, sessionId: params.sessionId);
}
