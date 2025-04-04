// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastModel _$CastModelFromJson(Map<String, dynamic> json) => CastModel(
  id: (json['id'] as num).toInt(),
  character: json['character'] as String,
  name: json['name'] as String,
  gender: (json['gender'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  profilePath: json['profile_path'] as String?,
);
