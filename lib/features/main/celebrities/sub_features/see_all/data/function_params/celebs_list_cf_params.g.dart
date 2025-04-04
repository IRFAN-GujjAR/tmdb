// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebs_list_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CelebsListCFParamsToJson(CelebsListCFParams instance) =>
    <String, dynamic>{
      'category': _$CelebsCFCategoryEnumMap[instance.category]!,
      'params_data': instance.data.toJson(),
    };

const _$CelebsCFCategoryEnumMap = {
  CelebsCFCategory.home: 'home',
  CelebsCFCategory.details: 'details',
  CelebsCFCategory.list: 'list',
};
