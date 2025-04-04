// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesModel _$MoviesModelFromJson(Map<String, dynamic> json) => MoviesModel(
  popular: MoviesListModel.fromJson(json['popular'] as Map<String, dynamic>),
  inTheatres: MoviesListModel.fromJson(
    json['in_theatres'] as Map<String, dynamic>,
  ),
  trending: MoviesListModel.fromJson(json['trending'] as Map<String, dynamic>),
  topRated: MoviesListModel.fromJson(json['top_rated'] as Map<String, dynamic>),
  upComing: MoviesListModel.fromJson(json['upcoming'] as Map<String, dynamic>),
);
