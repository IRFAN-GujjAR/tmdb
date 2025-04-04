import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/common/videos/video_model.dart';

import '../../../api/utils/json_keys_names.dart';

part 'videos_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class VideosModel extends Equatable {
  @JsonKey(name: JsonKeysNames.results)
  final List<VideoModel> videos;

  VideosModel({required this.videos});

  factory VideosModel.fromJson(Map<String, dynamic> json) =>
      _$VideosModelFromJson(json);

  @override
  List<Object?> get props => [videos];
}
