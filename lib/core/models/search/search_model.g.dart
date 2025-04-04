// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) => SearchModel(
  mediaType: json['media_type'] as String,
  title: json['title'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'media_type': instance.mediaType,
      'title': instance.title,
      'name': instance.name,
    };
