// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowsListModel _$TvShowsListModelFromJson(Map<String, dynamic> json) =>
    TvShowsListModel(
      pageNo: (json['page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      tvShows:
          (json['results'] as List<dynamic>)
              .map((e) => TvShowModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$TvShowsListModelToJson(TvShowsListModel instance) =>
    <String, dynamic>{
      'page': instance.pageNo,
      'total_pages': instance.totalPages,
      'results': instance.tvShows.map((e) => e.toJson()).toList(),
    };
