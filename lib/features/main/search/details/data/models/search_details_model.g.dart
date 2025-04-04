// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDetailsModel _$SearchDetailsModelFromJson(Map<String, dynamic> json) =>
    SearchDetailsModel(
      moviesList: MoviesListModel.fromJson(
        json['movies'] as Map<String, dynamic>,
      ),
      tvShowsList: TvShowsListModel.fromJson(
        json['tv_shows'] as Map<String, dynamic>,
      ),
      celebritiesList: CelebritiesListModel.fromJson(
        json['celebs'] as Map<String, dynamic>,
      ),
    );
