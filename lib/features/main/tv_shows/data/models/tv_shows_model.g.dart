// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_shows_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TvShowsModel _$TvShowsModelFromJson(Map<String, dynamic> json) => TvShowsModel(
  airingToday: TvShowsListModel.fromJson(
    json['airing_today'] as Map<String, dynamic>,
  ),
  trending: TvShowsListModel.fromJson(json['trending'] as Map<String, dynamic>),
  topRated: TvShowsListModel.fromJson(
    json['top_rated'] as Map<String, dynamic>,
  ),
  popular: TvShowsListModel.fromJson(json['popular'] as Map<String, dynamic>),
);
