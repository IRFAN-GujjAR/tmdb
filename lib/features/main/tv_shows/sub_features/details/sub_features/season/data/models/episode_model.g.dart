// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
  name: json['name'] as String,
  airDate: json['air_date'] as String?,
  overview: json['overview'] as String?,
  stillPath: json['still_path'] as String?,
  voteCount: (json['vote_count'] as num).toInt(),
  voteAverage: (json['vote_average'] as num).toDouble(),
);
