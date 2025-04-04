import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/common/backdrops/backdrop_image_entity.dart';
import 'package:tmdb/core/entities/common/collection_entity.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';
import 'package:tmdb/core/entities/common/production_company_entity.dart';
import 'package:tmdb/core/entities/common/videos/video_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';

final class MovieDetailsEntity extends Equatable {
  final String? backdropPath;
  final String? posterPath;
  final String title;
  final double voteAverage;
  final int voteCount;
  final List<GenreEntity> genres;
  final String? overview;
  final CollectionEntity? collection;
  final CreditsEntity? credits;
  final List<BackdropImageEntity> images;
  final List<VideoEntity> videos;
  final String? releaseDate;
  final String? language;
  final String budget;
  final String revenue;
  final List<ProductionCompanyEntity> productionCompanies;
  final MoviesListEntity? recommendedMovies;
  final MoviesListEntity? similarMovies;

  const MovieDetailsEntity(
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
