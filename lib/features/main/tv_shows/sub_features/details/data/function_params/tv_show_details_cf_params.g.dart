// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_details_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TvShowDetailsCFParamsToJson(
  TvShowDetailsCFParams instance,
) => <String, dynamic>{
  'category': _$TvShowsCFCategoryEnumMap[instance.category]!,
  'params_data': instance.data.toJson(),
};

const _$TvShowsCFCategoryEnumMap = {
  TvShowsCFCategory.home: 'home',
  TvShowsCFCategory.list: 'list',
  TvShowsCFCategory.details: 'details',
  TvShowsCFCategory.season: 'season',
};
