import '../../entities/favorite_media_entity.dart';

final class FavoriteMediaParams {
  final int userId;
  final String sessionId;
  final FavoriteMediaEntity favoriteMedia;

  FavoriteMediaParams(
      {required this.userId,
      required this.sessionId,
      required this.favoriteMedia});
}
