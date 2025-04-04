import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/tv_show/creator_model.dart';
import 'package:tmdb/core/models/tv_show/season/season_model.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';
import '../../../../../../../core/models/common/backdrops/backdrop_images_model.dart';
import '../../../../../../../core/models/common/credits/credits_model.dart';
import '../../../../../../../core/models/common/genre_model.dart';
import '../../../../../../../core/models/common/production_company_model.dart';
import '../../../../../../../core/models/common/videos/videos_model.dart';
import '../../../../../../../core/models/tv_show/network_model.dart';

part 'tv_show_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class TvShowDetailsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.name)
  final String name;
  @JsonKey(name: JsonKeysNames.voteAverage)
  final double voteAverage;
  @JsonKey(name: JsonKeysNames.voteCount)
  final int voteCount;
  @JsonKey(name: JsonKeysNames.genres)
  final List<GenreModel> genres;
  @JsonKey(name: JsonKeysNames.overview)
  final String? overview;
  @JsonKey(name: JsonKeysNames.seasons)
  final List<SeasonModel> seasons;
  @JsonKey(name: JsonKeysNames.credits)
  final CreditsModel? credits;
  @JsonKey(name: JsonKeysNames.images)
  final BackdropImagesModel images;
  @JsonKey(name: JsonKeysNames.videos)
  final VideosModel videos;
  @JsonKey(name: JsonKeysNames.createdBy)
  final List<CreatorModel> createBy;
  @JsonKey(name: JsonKeysNames.firstAirDate)
  final String? firstAirDate;
  @JsonKey(name: JsonKeysNames.language)
  final String? language;
  @JsonKey(name: JsonKeysNames.countryOrigin)
  final List<String> countryOrigin;
  @JsonKey(name: JsonKeysNames.networks)
  final List<NetworkModel>? networks;
  @JsonKey(name: JsonKeysNames.productionCompanies)
  final List<ProductionCompanyModel> productionCompanies;
  @JsonKey(name: JsonKeysNames.recommendations)
  final TvShowsListModel? recommendedTvShows;
  @JsonKey(name: JsonKeysNames.similar)
  final TvShowsListModel? similarTvShows;

  TvShowDetailsModel(
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

  factory TvShowDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsModelFromJson(json);

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
