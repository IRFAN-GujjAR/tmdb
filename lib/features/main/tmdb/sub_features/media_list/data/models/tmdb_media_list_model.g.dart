// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_media_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TMDbMediaListModel _$TMDbMediaListModelFromJson(Map<String, dynamic> json) =>
    TMDbMediaListModel(
      moviesList: MoviesListModel.fromJson(
        json['movies'] as Map<String, dynamic>,
      ),
      tvShowsList: TvShowsListModel.fromJson(
        json['tv_shows'] as Map<String, dynamic>,
      ),
    );
