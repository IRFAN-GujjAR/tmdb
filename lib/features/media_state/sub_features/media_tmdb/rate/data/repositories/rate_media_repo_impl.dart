import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/data_sources/rate_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/models/rate_media_model.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';

import '../../domain/repositories/rate_media_repo.dart';

final class RateMediaRepoImpl implements RateMediaRepo {
  final RateMediaDataSource _dataSource;

  RateMediaRepoImpl(this._dataSource);

  @override
  Future<RateMediaResultEntity> rateMovie(
          {required int movieId,
          required String sessionId,
          required RateMediaEntity rateMedia}) =>
      _dataSource.rateMovie(
          movieId: movieId,
          sessionId: sessionId,
          rateMedia: RateMediaModel(rating: rateMedia.rating));

  @override
  Future<RateMediaResultEntity> rateTvShow(
          {required int tvShowId,
          required String sessionId,
          required RateMediaEntity rateMedia}) =>
      _dataSource.rateTvShow(
          tvShowId: tvShowId,
          sessionId: sessionId,
          rateMedia: RateMediaModel(rating: rateMedia.rating));

  @override
  Future<RateMediaResultEntity> deleteMovieRating(
          {required int movieId, required String sessionId}) =>
      _dataSource.deleteMovieRating(movieId: movieId, sessionId: sessionId);

  @override
  Future<RateMediaResultEntity> deleteTvShowRating(
          {required int tvShowId, required String sessionId}) =>
      _dataSource.deleteTvShowRating(tvShowId: tvShowId, sessionId: sessionId);
}
