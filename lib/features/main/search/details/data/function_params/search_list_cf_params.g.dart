// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$SearchListCFParamsToJson(SearchListCFParams instance) =>
    <String, dynamic>{
      'category': _$SearchCFCategoryEnumMap[instance.category]!,
      'params_data': instance.data.toJson(),
    };

const _$SearchCFCategoryEnumMap = {
  SearchCFCategory.trending: 'trending',
  SearchCFCategory.multiSearch: 'multi_search',
  SearchCFCategory.details: 'details',
  SearchCFCategory.list: 'list',
};
