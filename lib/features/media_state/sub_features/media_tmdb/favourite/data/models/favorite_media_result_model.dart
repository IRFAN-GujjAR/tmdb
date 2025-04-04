import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/favourite/domain/entities/favorite_media_result_entity.dart';

part 'favorite_media_result_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class FavoriteMediaResultModel extends FavoriteMediaResultEntity {
  const FavoriteMediaResultModel(
      {required super.statusCode, required super.statusMessage});

  factory FavoriteMediaResultModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteMediaResultModelFromJson(json);
}
