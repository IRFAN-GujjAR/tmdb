// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SeasonCFParamsToJson(SeasonCFParams instance) =>
    <String, dynamic>{
      'category': _$TvShowsCFCategoryEnumMap[instance.category]!,
      'params_data': instance.data.toJson(),
    };

const _$TvShowsCFCategoryEnumMap = {
  TvShowsCFCategory.home: 'home',
  TvShowsCFCategory.list: 'list',
  TvShowsCFCategory.details: 'details',
  TvShowsCFCategory.season: 'season',
};
