// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorEntity _$ErrorEntityFromJson(Map<String, dynamic> json) => ErrorEntity(
  errorMessage: json['error_message'] as String,
  httpCode: (json['http_code'] as num).toInt(),
  tMDBCode: (json['tmdb_code'] as num).toInt(),
);
