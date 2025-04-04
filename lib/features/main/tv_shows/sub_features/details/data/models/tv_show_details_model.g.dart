// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowDetailsModel _$TvShowDetailsModelFromJson(
  Map<String, dynamic> json,
) => TvShowDetailsModel(
  backdropPath: json['backdrop_path'] as String?,
  posterPath: json['poster_path'] as String?,
  name: json['name'] as String,
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  genres:
      (json['genres'] as List<dynamic>)
          .map((e) => GenreModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  overview: json['overview'] as String?,
  seasons:
      (json['seasons'] as List<dynamic>)
          .map((e) => SeasonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  credits:
      json['credits'] == null
          ? null
          : CreditsModel.fromJson(json['credits'] as Map<String, dynamic>),
  images: BackdropImagesModel.fromJson(json['images'] as Map<String, dynamic>),
  videos: VideosModel.fromJson(json['videos'] as Map<String, dynamic>),
  createBy:
      (json['created_by'] as List<dynamic>)
          .map((e) => CreatorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  firstAirDate: json['first_air_date'] as String?,
  language: json['original_language'] as String?,
  countryOrigin:
      (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  networks:
      (json['networks'] as List<dynamic>?)
          ?.map((e) => NetworkModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  productionCompanies:
      (json['production_companies'] as List<dynamic>)
          .map(
            (e) => ProductionCompanyModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
  recommendedTvShows:
      json['recommendations'] == null
          ? null
          : TvShowsListModel.fromJson(
            json['recommendations'] as Map<String, dynamic>,
          ),
  similarTvShows:
      json['similar'] == null
          ? null
          : TvShowsListModel.fromJson(json['similar'] as Map<String, dynamic>),
);
