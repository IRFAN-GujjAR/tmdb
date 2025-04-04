import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';

abstract class RateMediaRepo {
  Future<RateMediaResultEntity> rateMovie(
      {required int movieId,
      required String sessionId,
      required RateMediaEntity rateMedia});

  Future<RateMediaResultEntity> rateTvShow(
      {required int tvShowId,
      required String sessionId,
      required RateMediaEntity rateMedia});

  Future<RateMediaResultEntity> deleteMovieRating(
      {required int movieId, required String sessionId});

  Future<RateMediaResultEntity> deleteTvShowRating(
      {required int tvShowId, required String sessionId});
}
