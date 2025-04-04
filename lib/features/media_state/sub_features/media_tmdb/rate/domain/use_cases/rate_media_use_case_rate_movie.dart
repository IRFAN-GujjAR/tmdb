import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/repositories/rate_media_repo.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/use_cases/params/rate_media_rate_params.dart';

final class RateMediaUseCaseRateMovie
    implements UseCase<RateMediaResultEntity, RateMediaRateParams> {
  final RateMediaRepo _repo;

  RateMediaUseCaseRateMovie(this._repo);

  @override
  Future<RateMediaResultEntity> call(RateMediaRateParams params) =>
      _repo.rateMovie(
          movieId: params.mediaId,
          sessionId: params.sessionId,
          rateMedia: params.rateMedia);
}
