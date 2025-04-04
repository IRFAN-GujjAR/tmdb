import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/entities/common/backdrops/backdrop_image_entity.dart';

part 'backdrop_image_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class BackdropImageModel extends BackdropImageEntity {
  BackdropImageModel({required super.filePath});

  factory BackdropImageModel.fromJson(Map<String, dynamic> json) =>
      _$BackdropImageModelFromJson(json);
}
