// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CollectionCFParamsToJson(CollectionCFParams instance) =>
    <String, dynamic>{
      'category': _$MoviesCFCategoryEnumMap[instance.category]!,
      'params_data': instance.data.toJson(),
    };

const _$MoviesCFCategoryEnumMap = {
  MoviesCFCategory.home: 'home',
  MoviesCFCategory.list: 'list',
  MoviesCFCategory.details: 'details',
  MoviesCFCategory.collection: 'collection',
};
