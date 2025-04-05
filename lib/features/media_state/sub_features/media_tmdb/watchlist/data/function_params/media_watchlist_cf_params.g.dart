// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_watchlist_cf_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$MediaWatchlistCFParamsToJson(
  MediaWatchlistCFParams instance,
) => <String, dynamic>{
  'category': _$TMDbCFCategoryEnumMap[instance.category]!,
  'params_data': instance.data.toJson(),
};

const _$TMDbCFCategoryEnumMap = {
  TMDbCFCategory.login: 'login',
  TMDbCFCategory.accountDetails: 'account_details',
  TMDbCFCategory.mediaList: 'media_list',
  TMDbCFCategory.mediaState: 'media_state',
  TMDbCFCategory.mediaFavorite: 'media_favorite',
  TMDbCFCategory.mediaRate: 'media_rate',
  TMDbCFCategory.mediaWatchlist: 'media_watchlist',
};
