// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list_cf_params_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MoviesListCFParamsDataToJson(
  MoviesListCFParamsData instance,
) => <String, dynamic>{
  'list_category': _$MoviesListCFCategoryEnumMap[instance.listCategory]!,
  'page_no': instance.pageNo,
  'movie_id': instance.movieId,
};

const _$MoviesListCFCategoryEnumMap = {
  MoviesListCFCategory.popular: 'popular',
  MoviesListCFCategory.inTheatres: 'in_theatres',
  MoviesListCFCategory.trending: 'trending',
  MoviesListCFCategory.topRated: 'top_rated',
  MoviesListCFCategory.upComing: 'upcoming',
  MoviesListCFCategory.recommended: 'recommended',
  MoviesListCFCategory.similar: 'similar',
};
