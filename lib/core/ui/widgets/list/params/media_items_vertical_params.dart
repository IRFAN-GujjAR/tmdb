import 'package:flutter/material.dart';

import '../../../../entities/movie/movie_entity.dart';
import '../../../../entities/tv_show/tv_show_entity.dart';
import '../../../utils.dart';

final class MediaItemsVerticalParams {
  final ScrollController scrollController;
  final MediaType mediaType;
  final List<int> mediaIds;
  final List<String> mediaTitles;
  final List<List<int>> mediaGenres;
  final List<String?> posterPaths;
  final List<String?> backdropPaths;
  final List<double> voteAverages;
  final List<int> voteCounts;

  const MediaItemsVerticalParams({
    required this.scrollController,
    required this.mediaType,
    required this.mediaIds,
    required this.mediaTitles,
    required this.mediaGenres,
    required this.posterPaths,
    required this.backdropPaths,
    required this.voteAverages,
    required this.voteCounts,
  });

  factory MediaItemsVerticalParams.fromMovies(
    ScrollController scrollController,
    List<MovieEntity> movies,
  ) {
    final mediaIds = <int>[];
    final mediaTitles = <String>[];
    final mediaGenres = <List<int>>[];
    final posterPaths = <String?>[];
    final backdropPaths = <String?>[];
    final voteAverages = <double>[];
    final voteCounts = <int>[];

    movies.forEach((movie) {
      mediaIds.add(movie.id);
      mediaTitles.add(movie.title);
      mediaGenres.add(movie.genreIds);
      posterPaths.add(movie.posterPath);
      backdropPaths.add(movie.backdropPath);
      voteAverages.add(movie.voteAverage);
      voteCounts.add(movie.voteCount);
    });
    return MediaItemsVerticalParams(
      scrollController: scrollController,
      mediaType: MediaType.Movie,
      mediaIds: mediaIds,
      mediaTitles: mediaTitles,
      mediaGenres: mediaGenres,
      posterPaths: posterPaths,
      backdropPaths: backdropPaths,
      voteAverages: voteAverages,
      voteCounts: voteCounts,
    );
  }

  factory MediaItemsVerticalParams.fromTvShows(
    ScrollController scrollController,
    List<TvShowEntity> tvShows,
  ) {
    final mediaIds = <int>[];
    final mediaTitles = <String>[];
    final mediaGenres = <List<int>>[];
    final posterPaths = <String?>[];
    final backdropPaths = <String?>[];
    final voteAverages = <double>[];
    final voteCounts = <int>[];

    tvShows.forEach((tvShow) {
      mediaIds.add(tvShow.id);
      mediaTitles.add(tvShow.name);
      mediaGenres.add(tvShow.genreIds);
      posterPaths.add(tvShow.posterPath);
      backdropPaths.add(tvShow.backdropPath);
      voteAverages.add(tvShow.voteAverage);
      voteCounts.add(tvShow.voteCount);
    });
    return MediaItemsVerticalParams(
      scrollController: scrollController,
      mediaType: MediaType.TvShow,
      mediaIds: mediaIds,
      mediaTitles: mediaTitles,
      mediaGenres: mediaGenres,
      posterPaths: posterPaths,
      backdropPaths: backdropPaths,
      voteAverages: voteAverages,
      voteCounts: voteCounts,
    );
  }
}
