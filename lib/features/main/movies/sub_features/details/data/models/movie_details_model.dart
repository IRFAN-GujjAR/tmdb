import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/common/collection_model.dart';
import 'package:tmdb/core/models/common/genre_model.dart';
import 'package:tmdb/core/models/common/production_company_model.dart';
import 'package:tmdb/core/models/movie/movies_list_model.dart';

import '../../../../../../../core/api/utils/json_keys_names.dart';
import '../../../../../../../core/models/common/backdrops/backdrop_images_model.dart';
import '../../../../../../../core/models/common/credits/credits_model.dart';
import '../../../../../../../core/models/common/videos/videos_model.dart';

part 'movie_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class MovieDetailsModel extends Equatable {
  @JsonKey(name: JsonKeysNames.backdropPath)
  final String? backdropPath;
  @JsonKey(name: JsonKeysNames.posterPath)
  final String? posterPath;
  @JsonKey(name: JsonKeysNames.title)
  final String title;
  @JsonKey(name: JsonKeysNames.voteAverage)
  final double voteAverage;
  @JsonKey(name: JsonKeysNames.voteCount)
  final int voteCount;
  @JsonKey(name: JsonKeysNames.genres)
  final List<GenreModel> genres;
  @JsonKey(name: JsonKeysNames.overview)
  final String? overview;
  @JsonKey(name: JsonKeysNames.collection)
  final CollectionModel? collection;
  @JsonKey(name: JsonKeysNames.credits)
  final CreditsModel? credits;
  @JsonKey(name: JsonKeysNames.images)
  final BackdropImagesModel images;
  @JsonKey(name: JsonKeysNames.videos)
  final VideosModel videos;
  @JsonKey(name: JsonKeysNames.releaseDate)
  final String? releaseDate;
  @JsonKey(name: JsonKeysNames.language)
  final String? language;
  @JsonKey(name: JsonKeysNames.budget)
  final int budget;
  @JsonKey(name: JsonKeysNames.revenue)
  final int revenue;
  @JsonKey(name: JsonKeysNames.productionCompanies)
  final List<ProductionCompanyModel> productionCompanies;
  @JsonKey(name: JsonKeysNames.recommendations)
  final MoviesListModel? recommendedMovies;
  @JsonKey(name: JsonKeysNames.similar)
  final MoviesListModel? similarMovies;

  const MovieDetailsModel(
      {required this.backdropPath,
      required this.posterPath,
      required this.title,
      required this.voteAverage,
      required this.voteCount,
      required this.genres,
      required this.overview,
      required this.collection,
      required this.credits,
      required this.images,
      required this.videos,
      required this.releaseDate,
      required this.language,
      required this.budget,
      required this.revenue,
      required this.productionCompanies,
      required this.recommendedMovies,
      required this.similarMovies});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  @override
  List<Object?> get props => [
        backdropPath,
        posterPath,
        title,
        voteAverage,
        voteCount,
        genres,
        overview,
        collection,
        credits,
        images,
        videos,
        releaseDate,
        language,
        budget,
        revenue,
        productionCompanies,
        recommendedMovies,
        similarMovies
      ];
}
