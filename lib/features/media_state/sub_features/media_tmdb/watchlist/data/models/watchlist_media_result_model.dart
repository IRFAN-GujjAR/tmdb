import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_result_entity.dart';

part 'watchlist_media_result_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class WatchlistMediaResultModel extends WatchlistMediaResultEntity {
  const WatchlistMediaResultModel(
      {required super.statusCode, required super.statusMessage});

  factory WatchlistMediaResultModel.fromJson(Map<String, dynamic> json) =>
      _$WatchlistMediaResultModelFromJson(json);
}
