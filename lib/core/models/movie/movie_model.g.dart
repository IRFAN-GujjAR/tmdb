// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  genreIds:
      (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  voteCount: (json['vote_count'] as num).toInt(),
  voteAverage: (json['vote_average'] as num).toDouble(),
  releaseDate: json['release_date'] as String?,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'genre_ids': instance.genreIds,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
    };
