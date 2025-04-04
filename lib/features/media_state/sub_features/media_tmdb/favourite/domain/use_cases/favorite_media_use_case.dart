import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_result_entity.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/repositories/favorite_media_repo.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/use_cases/params/favorite_media_params.dart';

final class FavoriteMediaUseCase
    implements UseCase<FavoriteMediaResultEntity, FavoriteMediaParams> {
  final FavoriteMediaRepo _repo;

  FavoriteMediaUseCase(this._repo);

  @override
  Future<FavoriteMediaResultEntity> call(FavoriteMediaParams params) =>
      _repo.set(
          userId: params.userId,
          sessionId: params.sessionId,
          favoriteMedia: params.favoriteMedia);
}
