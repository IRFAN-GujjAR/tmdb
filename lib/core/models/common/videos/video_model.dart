import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/videos/video_entity.dart';

part 'video_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class VideoModel extends VideoEntity {
  VideoModel({required super.key, required super.name});

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
}
