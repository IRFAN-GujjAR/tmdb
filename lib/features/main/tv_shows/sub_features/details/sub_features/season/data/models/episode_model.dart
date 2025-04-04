import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/episode_entity.dart';

part 'episode_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class EpisodeModel extends EpisodeEntity {
  EpisodeModel(
      {required super.name,
      required super.airDate,
      required super.overview,
      required super.stillPath,
      required super.voteCount,
      required super.voteAverage});

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
}
