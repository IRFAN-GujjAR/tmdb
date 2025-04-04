import 'package:json_annotation/json_annotation.dart';

enum TMDbCFCategory {
  login,
  @JsonValue('media_list')
  mediaList,
  @JsonValue('media_state')
  mediaState,
  @JsonValue('media_favorite')
  mediaFavorite,
  @JsonValue('media_rate')
  mediaRate,
  @JsonValue('media_watchlist')
  mediaWatchlist,
}

enum TMDbMediaRateType { add, remove }
