// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_collection_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCollectionDetailsModel _$MovieCollectionDetailsModelFromJson(
  Map<String, dynamic> json,
) => MovieCollectionDetailsModel(
  name: json['name'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  movies:
      (json['parts'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);
