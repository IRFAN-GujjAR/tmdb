// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityModel _$CelebrityModelFromJson(Map<String, dynamic> json) =>
    CelebrityModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      knownFor: json['known_for_department'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$CelebrityModelToJson(CelebrityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'known_for_department': instance.knownFor,
      'profile_path': instance.profilePath,
    };
