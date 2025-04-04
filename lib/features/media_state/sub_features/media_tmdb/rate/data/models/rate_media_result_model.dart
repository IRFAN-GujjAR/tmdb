import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_result_entity.dart';

part 'rate_media_result_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class RateMediaResultModel extends RateMediaResultEntity {
  RateMediaResultModel(
      {required super.statusCode, required super.statusMessage});

  factory RateMediaResultModel.fromJson(Map<String, dynamic> json) =>
      _$RateMediaResultModelFromJson(json);
}
