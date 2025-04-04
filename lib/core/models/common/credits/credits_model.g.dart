// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credits_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditsModel _$CreditsModelFromJson(Map<String, dynamic> json) => CreditsModel(
  cast:
      (json['cast'] as List<dynamic>)
          .map((e) => CastModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  crew:
      (json['crew'] as List<dynamic>)
          .map((e) => CrewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);
