// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_season_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowSeasonDetailsModel _$TvShowSeasonDetailsModelFromJson(
  Map<String, dynamic> json,
) => TvShowSeasonDetailsModel(
  name: json['name'] as String,
  airDate: json['air_date'] as String,
  overview: json['overview'] as String?,
  posterPath: json['poster_path'] as String?,
  episodes:
      (json['episodes'] as List<dynamic>)
          .map((e) => EpisodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);
