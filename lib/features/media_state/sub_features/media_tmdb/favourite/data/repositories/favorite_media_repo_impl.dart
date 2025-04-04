import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/data_sources/favorite_media_data_source.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/models/favorite_media_model.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/data/models/favorite_media_result_model.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/repositories/favorite_media_repo.dart';

final class FavoriteMediaRepoImpl implements FavoriteMediaRepo {
  final FavoriteMediaDataSource _dataSource;

  FavoriteMediaRepoImpl(this._dataSource);

  @override
  Future<FavoriteMediaResultModel> set(
          {required int userId,
          required String sessionId,
          required FavoriteMediaEntity favoriteMedia}) =>
      _dataSource.set(
          userId: userId,
          sessionId: sessionId,
          favoriteMedia: FavoriteMediaModel(
              mediaType: favoriteMedia.mediaType,
              mediaId: favoriteMedia.mediaId,
              set: favoriteMedia.set));
}
