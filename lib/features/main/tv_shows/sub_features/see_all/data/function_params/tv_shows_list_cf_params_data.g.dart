// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows_list_cf_params_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TvShowsListCFParamsDataToJson(
  TvShowsListCFParamsData instance,
) => <String, dynamic>{
  'list_category': _$TvShowsListCFCategoryEnumMap[instance.listCategory]!,
  'page_no': instance.pageNo,
  'tv_id': instance.tvId,
};

const _$TvShowsListCFCategoryEnumMap = {
  TvShowsListCFCategory.airingToday: 'airing_today',
  TvShowsListCFCategory.trending: 'trending',
  TvShowsListCFCategory.topRated: 'top_rated',
  TvShowsListCFCategory.popular: 'popular',
  TvShowsListCFCategory.recommended: 'recommended',
  TvShowsListCFCategory.similar: 'similar',
};
