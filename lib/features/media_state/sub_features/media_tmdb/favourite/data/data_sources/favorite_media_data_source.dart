import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/function_params/media_favorite_cf_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/function_params/media_favorite_cf_params_data.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/models/favorite_media_result_model.dart';

import '../models/favorite_media_model.dart';

abstract class FavoriteMediaDataSource {
  Future<FavoriteMediaResultModel> set({
    required int userId,
    required String sessionId,
    required FavoriteMediaModel favoriteMedia,
  });
}

final class FavoriteMediaDataSourceImpl implements FavoriteMediaDataSource {
  final HttpsCallable _function;

  const FavoriteMediaDataSourceImpl(this._function);

  @override
  Future<FavoriteMediaResultModel> set({
    required int userId,
    required String sessionId,
    required FavoriteMediaModel favoriteMedia,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      MediaFavoriteCFParams(
        category: TMDbCFCategory.mediaFavorite,
        data: MediaFavoriteCFParamsData(
          sessionId: sessionId,
          body: favoriteMedia,
        ),
      ).toJson(),
    );
    return FavoriteMediaResultModel.fromJson(data);
  }
}
