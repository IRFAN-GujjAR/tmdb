import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/app_version_entity.dart';

part 'app_version_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class AppVersionModel extends AppVersionEntity {
  AppVersionModel({
    required super.installedVersion,
    required super.playStoreVersion,
    required super.minRequiredVersion,
  });

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
}
