import 'package:json_annotation/json_annotation.dart';

import '../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_media_state_type_cf_category.dart';
import '../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'media_state_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class MediaStateCFParamsData {
  final TMDbMediaStateTypeCFCategory type;
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;
  @JsonKey(name: CFJsonKeys.MEDIA_ID)
  final int mediaId;

  const MediaStateCFParamsData({
    required this.type,
    required this.sessionId,
    required this.mediaId,
  });

  Map<String, dynamic> toJson() => _$MediaStateCFParamsDataToJson(this);
}
