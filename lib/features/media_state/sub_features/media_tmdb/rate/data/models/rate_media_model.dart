import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/domain/entities/rate_media_entity.dart';

part 'rate_media_model.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
final class RateMediaModel extends RateMediaEntity {
  RateMediaModel({required super.rating});

  Map<String, dynamic> toJson() => _$RateMediaModelToJson(this);
}
