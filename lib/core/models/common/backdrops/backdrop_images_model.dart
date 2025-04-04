import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../api/utils/json_keys_names.dart';
import 'backdrop_image_model.dart';

part 'backdrop_images_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class BackdropImagesModel extends Equatable {
  @JsonKey(name: JsonKeysNames.backdrops)
  final List<BackdropImageModel> backdrops;

  BackdropImagesModel({required this.backdrops});

  factory BackdropImagesModel.fromJson(Map<String, dynamic> json) =>
      _$BackdropImagesModelFromJson(json);

  @override
  List<Object?> get props => [backdrops];
}
