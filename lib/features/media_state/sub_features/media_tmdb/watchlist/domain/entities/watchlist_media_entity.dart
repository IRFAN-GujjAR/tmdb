import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';

class WatchlistMediaEntity {
  @JsonKey(name: JsonKeysNames.mediaType)
  final String mediaType;
  @JsonKey(name: JsonKeysNames.mediaId)
  final int mediaId;
  @JsonKey(name: JsonKeysNames.watchlist)
  final bool set;

  const WatchlistMediaEntity(
      {required this.mediaType, required this.mediaId, required this.set});
}
