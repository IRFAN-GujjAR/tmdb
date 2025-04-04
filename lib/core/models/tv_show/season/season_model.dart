import 'package:json_annotation/json_annotation.dart';

import '../../../entities/tv_show/season/season_entity.dart';

part 'season_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class SeasonModel extends SeasonEntity {
  SeasonModel(
      {required super.id,
      required super.seasonNo,
      required super.name,
      super.posterPath});

  factory SeasonModel.fromJson(Map<String, dynamic> json) =>
      _$SeasonModelFromJson(json);
}
