// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'celebrity_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CelebrityDetailsModel _$CelebrityDetailsModelFromJson(
  Map<String, dynamic> json,
) => CelebrityDetailsModel(
  name: json['name'] as String,
  department: json['known_for_department'] as String?,
  birthday: json['birthday'] as String?,
  deathDay: json['deathday'] as String?,
  biography: json['biography'] as String?,
  birthPlace: json['place_of_birth'] as String?,
  profilePath: json['profile_path'] as String?,
  movieCredits:
      json['movie_credits'] == null
          ? null
          : MovieCreditsModel.fromJson(
            json['movie_credits'] as Map<String, dynamic>,
          ),
  tvCredits:
      json['tv_credits'] == null
          ? null
          : TvShowCreditsModel.fromJson(
            json['tv_credits'] as Map<String, dynamic>,
          ),
);
