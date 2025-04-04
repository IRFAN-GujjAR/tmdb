// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsModel _$MovieDetailsModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailsModel(
  backdropPath: json['backdrop_path'] as String?,
  posterPath: json['poster_path'] as String?,
  title: json['title'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  genres:
      (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  overview: json['overview'] as String?,
  collection:
      json['belongs_to_collection'] == null
          ? null
          : CollectionModel.fromJson(
            json['belongs_to_collection'] as Map<String, dynamic>,
          ),
  credits:
      json['credits'] == null
          ? null
          : CreditsModel.fromJson(json['credits'] as Map<String, dynamic>),
  images: BackdropImagesModel.fromJson(json['images'] as Map<String, dynamic>),
  videos: VideosModel.fromJson(json['videos'] as Map<String, dynamic>),
  releaseDate: json['release_date'] as String?,
  language: json['original_language'] as String?,
  budget: (json['budget'] as num).toInt(),
  revenue: (json['revenue'] as num).toInt(),
  productionCompanies:
      (json['production_companies'] as List<dynamic>)
          .map(
            (e) => ProductionCompanyModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  recommendedMovies:
      json['recommendations'] == null
          ? null
          : MoviesListModel.fromJson(
            json['recommendations'] as Map<String, dynamic>,
          ),
  similarMovies:
      json['similar'] == null
          ? null
          : MoviesListModel.fromJson(json['similar'] as Map<String, dynamic>),
);
