import 'package:tmdb/core/entities/movie/movie_entity.dart';
import 'package:tmdb/core/entities/tv_show/tv_show_entity.dart';

import '../../../utils.dart';
import 'config/media_items_horizontal_config.dart';

final class MediaItemsHorizontalParams {
  final MediaType mediaType;
  final List<int> mediaIds;
  final List<String> mediaTitles;
  final List<List<int>> mediaGenres;
  final List<String?> posterPaths;
  final List<String?> backdropPaths;
  final String previousPageTitle;
  final bool isLandscape;
  final MediaItemsHorizontalConfig config;

  const MediaItemsHorizontalParams({
    required this.mediaType,
    required this.mediaIds,
    required this.mediaTitles,
    required this.mediaGenres,
    required this.posterPaths,
    required this.backdropPaths,
    required this.previousPageTitle,
    required this.isLandscape,
    required this.config,
  });

  factory MediaItemsHorizontalParams.fromMovies({
    required List<MovieEntity> movies,
    required String previousPageTitle,
    required bool isLandscape,
    required MediaItemsHorizontalConfig config,
  }) {
    final List<int> mediaIds = [];
    final List<String> mediaNames = [];
    final List<List<int>> mediaGenres = [];
    final List<String?> posterPaths = [];
    final List<String?> backdropPaths = [];
    movies.forEach((movie) {
      mediaIds.add(movie.id);
      mediaNames.add(movie.title);
      mediaGenres.add(movie.genreIds);
      posterPaths.add(movie.posterPath);
      backdropPaths.add(movie.backdropPath);
    });
    return MediaItemsHorizontalParams(
      mediaType: MediaType.Movie,
      mediaIds: mediaIds,
      mediaTitles: mediaNames,
      mediaGenres: mediaGenres,
      posterPaths: posterPaths,
      backdropPaths: backdropPaths,
      previousPageTitle: previousPageTitle,
      isLandscape: isLandscape,
      config: config,
    );
  }

  factory MediaItemsHorizontalParams.fromTvShows({
    required List<TvShowEntity> tvShows,
    required String previousPageTitle,
    required bool isLandscape,
    required MediaItemsHorizontalConfig config,
  }) {
    final List<int> mediaIds = [];
    final List<String> mediaNames = [];
    final List<List<int>> mediaGenres = [];
    final List<String?> posterPaths = [];
    final List<String?> backdropPaths = [];
    tvShows.forEach((movie) {
      mediaIds.add(movie.id);
      mediaNames.add(movie.name);
      mediaGenres.add(movie.genreIds);
      posterPaths.add(movie.posterPath);
      backdropPaths.add(movie.backdropPath);
    });
    return MediaItemsHorizontalParams(
      mediaType: MediaType.TvShow,
      mediaIds: mediaIds,
      mediaTitles: mediaNames,
      mediaGenres: mediaGenres,
      posterPaths: posterPaths,
      backdropPaths: backdropPaths,
      previousPageTitle: previousPageTitle,
      isLandscape: isLandscape,
      config: config,
    );
  }
}
