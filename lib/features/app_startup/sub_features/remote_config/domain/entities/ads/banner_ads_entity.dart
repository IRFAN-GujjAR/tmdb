import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class BannerAdsEntity extends Equatable {
  @JsonKey(name: 'movies_id')
  final String moviesId;
  @JsonKey(name: 'tv_shows_id')
  final String tvShowsId;
  @JsonKey(name: 'celebs_id')
  final String celebsId;
  @JsonKey(name: 'search_id')
  final String searchId;
  @JsonKey(name: 'tmdb_id')
  final String tmdbId;

  BannerAdsEntity({
    required this.moviesId,
    required this.tvShowsId,
    required this.celebsId,
    required this.searchId,
    required this.tmdbId,
  });

  @override
  List<Object?> get props => [moviesId, tvShowsId, celebsId, searchId, tmdbId];
}
