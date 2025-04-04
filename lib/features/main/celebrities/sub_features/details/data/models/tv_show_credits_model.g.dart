// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowCreditsModel _$TvShowCreditsModelFromJson(Map<String, dynamic> json) =>
    TvShowCreditsModel(
      cast:
          (json['cast'] as List<dynamic>)
              .map((e) => TvShowModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      crew:
          (json['crew'] as List<dynamic>)
              .map((e) => TvShowModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
