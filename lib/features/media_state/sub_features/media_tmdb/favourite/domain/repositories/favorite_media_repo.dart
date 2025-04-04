import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_result_entity.dart';

import '../entities/favorite_media_entity.dart';

abstract class FavoriteMediaRepo {
  Future<FavoriteMediaResultEntity> set(
      {required int userId,
      required String sessionId,
      required FavoriteMediaEntity favoriteMedia});
}
