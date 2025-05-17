import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class BannerAdsEntity extends Equatable {
  @JsonKey(name: 'movies_id')
  final String moviesId;
  @JsonKey(name: 'movies_id_ios')
  final String moviesIdIOS;
  @JsonKey(name: 'tv_shows_id')
  final String tvShowsId;
  @JsonKey(name: 'tv_shows_id_ios')
  final String tvShowsIdIOS;
  @JsonKey(name: 'celebs_id')
  final String celebsId;
  @JsonKey(name: 'celebs_id_ios')
  final String celebsIdIOS;
  @JsonKey(name: 'search_id')
  final String searchId;
  @JsonKey(name: 'search_id_ios')
  final String searchIdIOS;
  @JsonKey(name: 'tmdb_id')
  final String tmdbId;
  @JsonKey(name: 'tmdb_id_ios')
  final String tmdbIdIOS;

  BannerAdsEntity({
    required this.moviesId,
    required this.moviesIdIOS,
    required this.tvShowsId,
    required this.tvShowsIdIOS,
    required this.celebsId,
    required this.celebsIdIOS,
    required this.searchId,
    required this.searchIdIOS,
    required this.tmdbId,
    required this.tmdbIdIOS,
  });

  @override
  List<Object?> get props => [
    moviesId,
    moviesIdIOS,
    tvShowsId,
    tvShowsIdIOS,
    celebsId,
    celebsIdIOS,
    searchId,
    searchIdIOS,
    tmdbId,
    tmdbIdIOS,
  ];
}
