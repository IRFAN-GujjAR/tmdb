import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/models/watchlist_media_model.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'media_watchlist_cf_params_data.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class MediaWatchlistCFParamsData {
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;
  final WatchlistMediaModel body;

  const MediaWatchlistCFParamsData({
    required this.sessionId,
    required this.body,
  });

  Map<String, dynamic> toJson() => _$MediaWatchlistCFParamsDataToJson(this);
}
