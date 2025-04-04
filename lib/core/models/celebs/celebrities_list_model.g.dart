// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrities_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebritiesListModel _$CelebritiesListModelFromJson(
  Map<String, dynamic> json,
) => CelebritiesListModel(
  pageNo: (json['page'] as num).toInt(),
  totalPages: (json['total_pages'] as num).toInt(),
  celebrities:
      (json['results'] as List<dynamic>)
          .map((e) => CelebrityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CelebritiesListModelToJson(
  CelebritiesListModel instance,
) => <String, dynamic>{
  'page': instance.pageNo,
  'total_pages': instance.totalPages,
  'results': instance.celebrities.map((e) => e.toJson()).toList(),
};
