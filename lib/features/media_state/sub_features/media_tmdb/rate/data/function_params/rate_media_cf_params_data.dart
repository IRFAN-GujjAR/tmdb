import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/rate/data/models/rate_media_model.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'rate_media_cf_params_data.g.dart';

@JsonSerializable(createFactory: false, explicitToJson: true)
final class RateMediaCFParamsData {
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;
  @JsonKey(name: CFJsonKeys.MEDIA_ID)
  final int mediaId;
  @JsonKey(name: CFJsonKeys.MEDIA_TYPE)
  final TMDbMediaStateTypeCFCategory mediaType;
  final TMDbMediaRateType type;
  final RateMediaModel? body;

  const RateMediaCFParamsData({
    required this.sessionId,
    required this.mediaId,
    required this.mediaType,
    required this.type,
    this.body,
  });

  Map<String, dynamic> toJson() => _$RateMediaCFParamsDataToJson(this);
}
