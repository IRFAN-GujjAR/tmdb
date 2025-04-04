// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeasonModel _$SeasonModelFromJson(Map<String, dynamic> json) => SeasonModel(
  id: (json['id'] as num).toInt(),
  seasonNo: (json['season_number'] as num).toInt(),
  name: json['name'] as String,
  posterPath: json['poster_path'] as String?,
);
