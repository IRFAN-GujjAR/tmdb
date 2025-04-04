import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/domain/entities/watchlist_media_entity.dart';

part 'watchlist_media_model.g.dart';

@JsonSerializable(createFactory: false, ignoreUnannotated: true)
final class WatchlistMediaModel extends WatchlistMediaEntity {
  const WatchlistMediaModel(
      {required super.mediaType, required super.mediaId, required super.set});

  Map<String, dynamic> toJson() => _$WatchlistMediaModelToJson(this);
}
