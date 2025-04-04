import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_entity.dart';

part 'favorite_media_model.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
final class FavoriteMediaModel extends FavoriteMediaEntity {
  FavoriteMediaModel(
      {required super.mediaType, required super.mediaId, required super.set});

  Map<String, dynamic> toJson() => _$FavoriteMediaModelToJson(this);
}
