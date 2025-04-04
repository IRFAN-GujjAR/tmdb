import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/common/backdrops/backdrop_image_entity.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';
import 'package:tmdb/core/entities/common/production_company_entity.dart';
import 'package:tmdb/core/entities/common/videos/video_entity.dart';
import 'package:tmdb/core/entities/tv_show/creator_entity.dart';
import 'package:tmdb/core/entities/tv_show/network_entity.dart';
import 'package:tmdb/core/entities/tv_show/season/season_entity.dart';
import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';

final class TvShowDetailsEntity extends Equatable {
  final String? backdropPath;
  final String? posterPath;
  final String name;
  final double voteAverage;
  final int voteCount;
  final List<GenreEntity> genres;
  final String? overview;
  final List<SeasonEntity> seasons;
  final CreditsEntity? credits;
  final List<BackdropImageEntity> images;
  final List<VideoEntity> videos;
  final List<CreatorEntity> createBy;
  final String? firstAirDate;
  final String? language;
  final List<String> countryOrigin;
  final List<NetworkEntity>? networks;
  final List<ProductionCompanyEntity> productionCompanies;
  final TvShowsListEntity? recommendedTvShows;
  final TvShowsListEntity? similarTvShows;

  TvShowDetailsEntity(
      {required this.backdropPath,
      required this.posterPath,
      required this.name,
      required this.voteAverage,
      required this.voteCount,
      required this.genres,
      required this.overview,
      required this.seasons,
      required this.credits,
      required this.images,
      required this.videos,
      required this.createBy,
      required this.firstAirDate,
      required this.language,
      required this.countryOrigin,
      required this.networks,
      required this.productionCompanies,
      required this.recommendedTvShows,
      required this.similarTvShows});

  @override
  List<Object?> get props => [
        backdropPath,
        posterPath,
        name,
        voteAverage,
        voteCount,
        genres,
        overview,
        seasons,
        credits,
        images,
        videos,
        createBy,
        firstAirDate,
        language,
        countryOrigin,
        networks,
        productionCompanies,
        recommendedTvShows,
        similarTvShows
      ];
}
