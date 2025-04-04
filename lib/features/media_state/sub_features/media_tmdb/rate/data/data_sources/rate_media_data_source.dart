import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/function_params/rate_media_cf_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/function_params/rate_media_cf_params_data.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/models/rate_media_result_model.dart';

import '../models/rate_media_model.dart';

abstract class RateMediaDataSource {
  Future<RateMediaResultModel> rateMovie({
    required int movieId,
    required String sessionId,
    required RateMediaModel rateMedia,
  });

  Future<RateMediaResultModel> rateTvShow({
    required int tvShowId,
    required String sessionId,
    required RateMediaModel rateMedia,
  });

  Future<RateMediaResultModel> deleteMovieRating({
    required int movieId,
    required String sessionId,
  });

  Future<RateMediaResultModel> deleteTvShowRating({
    required int tvShowId,
    required String sessionId,
  });
}

final class RateMediaDataSourceImpl implements RateMediaDataSource {
  final HttpsCallable _function;

  const RateMediaDataSourceImpl(this._function);

  @override
  Future<RateMediaResultModel> rateMovie({
    required int movieId,
    required String sessionId,
    required RateMediaModel rateMedia,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      RateMediaCFParams(
        category: TMDbCFCategory.mediaRate,
        data: RateMediaCFParamsData(
          sessionId: sessionId,
          mediaId: movieId,
          mediaType: TMDbMediaStateTypeCFCategory.movie,
          type: TMDbMediaRateType.add,
          body: rateMedia,
        ),
      ).toJson(),
    );
    return RateMediaResultModel.fromJson(data);
  }

  @override
  Future<RateMediaResultModel> rateTvShow({
    required int tvShowId,
    required String sessionId,
    required RateMediaModel rateMedia,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      RateMediaCFParams(
        category: TMDbCFCategory.mediaRate,
        data: RateMediaCFParamsData(
          sessionId: sessionId,
          mediaId: tvShowId,
          mediaType: TMDbMediaStateTypeCFCategory.tv,
          type: TMDbMediaRateType.add,
          body: rateMedia,
        ),
      ).toJson(),
    );
    return RateMediaResultModel.fromJson(data);
  }

  @override
  Future<RateMediaResultModel> deleteMovieRating({
    required int movieId,
    required String sessionId,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      RateMediaCFParams(
        category: TMDbCFCategory.mediaRate,
        data: RateMediaCFParamsData(
          sessionId: sessionId,
          mediaId: movieId,
          mediaType: TMDbMediaStateTypeCFCategory.movie,
          type: TMDbMediaRateType.remove,
        ),
      ).toJson(),
    );
    return RateMediaResultModel.fromJson(data);
  }

  @override
  Future<RateMediaResultModel> deleteTvShowRating({
    required int tvShowId,
    required String sessionId,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      RateMediaCFParams(
        category: TMDbCFCategory.mediaRate,
        data: RateMediaCFParamsData(
          sessionId: sessionId,
          mediaId: tvShowId,
          mediaType: TMDbMediaStateTypeCFCategory.tv,
          type: TMDbMediaRateType.remove,
        ),
      ).toJson(),
    );
    return RateMediaResultModel.fromJson(data);
  }
}
