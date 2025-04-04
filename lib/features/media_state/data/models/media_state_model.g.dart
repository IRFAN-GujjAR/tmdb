// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaStateModel _$MediaStateModelFromJson(Map<String, dynamic> json) =>
    MediaStateModel(
      id: (json['id'] as num).toInt(),
      favorite: json['favorite'] as bool,
      rated: RatedModelConverter.fromJson(json['rated']),
      watchlist: json['watchlist'] as bool,
    );
