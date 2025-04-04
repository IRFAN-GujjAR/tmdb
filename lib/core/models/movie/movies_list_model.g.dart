// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesListModel _$MoviesListModelFromJson(Map<String, dynamic> json) =>
    MoviesListModel(
      pageNo: (json['page'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
      movies:
          (json['results'] as List<dynamic>)
              .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MoviesListModelToJson(MoviesListModel instance) =>
    <String, dynamic>{
      'page': instance.pageNo,
      'total_pages': instance.totalPages,
      'results': instance.movies.map((e) => e.toJson()).toList(),
    };
