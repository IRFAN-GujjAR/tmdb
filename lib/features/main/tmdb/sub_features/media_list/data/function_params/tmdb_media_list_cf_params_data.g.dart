// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_media_list_cf_params_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$TMDbMediaListCfParamsDataToJson(
  TMDbMediaListCfParamsData instance,
) => <String, dynamic>{
  'list_category': _$TMDbMediaListCFCategoryEnumMap[instance.listCategory]!,
  'list_type': _$TMDbMediaListTypeCFCategoryEnumMap[instance.listType]!,
  'user_id': instance.userId,
  'session_id': instance.sessionId,
  'page_no': instance.pageNo,
  'sort_by': _$SortByCFCategoryEnumMap[instance.sortBy]!,
};

const _$TMDbMediaListCFCategoryEnumMap = {
  TMDbMediaListCFCategory.favorites: 'favorites',
  TMDbMediaListCFCategory.ratings: 'ratings',
  TMDbMediaListCFCategory.watchlist: 'watchlist',
};

const _$TMDbMediaListTypeCFCategoryEnumMap = {
  TMDbMediaListTypeCFCategory.movie: 'movie',
  TMDbMediaListTypeCFCategory.tv: 'tv',
  TMDbMediaListTypeCFCategory.both: 'both',
};

const _$SortByCFCategoryEnumMap = {
  SortByCFCategory.asc: 'asc',
  SortByCFCategory.desc: 'desc',
};
