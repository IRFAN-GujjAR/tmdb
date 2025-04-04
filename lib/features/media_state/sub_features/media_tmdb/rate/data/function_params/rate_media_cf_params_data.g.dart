// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rate_media_cf_params_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$RateMediaCFParamsDataToJson(
  RateMediaCFParamsData instance,
) => <String, dynamic>{
  'session_id': instance.sessionId,
  'media_id': instance.mediaId,
  'media_type': _$TMDbMediaStateTypeCFCategoryEnumMap[instance.mediaType]!,
  'type': _$TMDbMediaRateTypeEnumMap[instance.type]!,
  'body': instance.body?.toJson(),
};

const _$TMDbMediaStateTypeCFCategoryEnumMap = {
  TMDbMediaStateTypeCFCategory.movie: 'movie',
  TMDbMediaStateTypeCFCategory.tv: 'tv',
};

const _$TMDbMediaRateTypeEnumMap = {
  TMDbMediaRateType.add: 'add',
  TMDbMediaRateType.remove: 'remove',
};
