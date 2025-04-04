// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list_cf_params_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SearchListCFParamsDataToJson(
  SearchListCFParamsData instance,
) => <String, dynamic>{
  'list_category': _$SearchListCFCategoryEnumMap[instance.listCategory]!,
  'query': instance.query,
  'page_no': instance.pageNo,
};

const _$SearchListCFCategoryEnumMap = {
  SearchListCFCategory.movie: 'movie',
  SearchListCFCategory.tv: 'tv',
  SearchListCFCategory.person: 'person',
};
