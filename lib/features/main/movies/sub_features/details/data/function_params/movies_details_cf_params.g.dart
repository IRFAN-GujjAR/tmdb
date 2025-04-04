// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_details_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MovieDetailsCFParamsToJson(
  MovieDetailsCFParams instance,
) => <String, dynamic>{
  'category': _$MoviesCFCategoryEnumMap[instance.category]!,
  'params_data': instance.data.toJson(),
};

const _$MoviesCFCategoryEnumMap = {
  MoviesCFCategory.home: 'home',
  MoviesCFCategory.list: 'list',
  MoviesCFCategory.details: 'details',
  MoviesCFCategory.collection: 'collection',
};
