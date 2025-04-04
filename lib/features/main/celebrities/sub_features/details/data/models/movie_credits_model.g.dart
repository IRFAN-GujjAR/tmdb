// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCreditsModel _$MovieCreditsModelFromJson(Map<String, dynamic> json) =>
    MovieCreditsModel(
      cast:
          (json['cast'] as List<dynamic>)
              .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      crew:
          (json['crew'] as List<dynamic>)
              .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
