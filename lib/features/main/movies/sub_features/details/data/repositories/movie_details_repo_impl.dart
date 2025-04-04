import 'package:tmdb/core/entities/common/backdrops/backdrop_image_entity.dart';
import 'package:tmdb/core/entities/common/credits/credits_entity.dart';
import 'package:tmdb/core/entities/common/videos/video_entity.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/models/movie/movies_list_model.dart';
import 'package:tmdb/core/ui/date/date_utl.dart';
import 'package:tmdb/core/ui/language/lang_utl.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/data_sources/movie_details_data_source.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/entities/movie_details_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/repositories/movie_details_repo.dart';

final class MovieDetailsRepoImpl implements MovieDetailsRepo {
  final MovieDetailsDataSource _dataSource;

  MovieDetailsRepoImpl(this._dataSource);

  @override
  Future<MovieDetailsEntity> loadMovieDetails(int movieId) async {
    final movieDetails = await _dataSource.loadMovieDetails(movieId);
    CreditsEntity? credits;
    if (movieDetails.credits != null) {
      credits = CreditsEntity(
          cast: movieDetails.credits!.cast, crew: movieDetails.credits!.crew);
    }
    final images = movieDetails.images.backdrops
        .map((e) => BackdropImageEntity(filePath: e.filePath))
        .toList();
    final videos = movieDetails.videos.videos
        .map((e) => VideoEntity(key: e.key, name: e.name))
        .toList();
    MoviesListModel? recommendedModel = movieDetails.recommendedMovies;
    MoviesListEntity? recommendedEntity;
    if (recommendedModel != null) {
      recommendedEntity = MoviesListEntity(
          pageNo: recommendedModel.pageNo,
          totalPages: recommendedModel.totalPages,
          movies: recommendedModel.movies);
    }

    MoviesListModel? similarModel = movieDetails.similarMovies;
    MoviesListEntity? similarEntity;
    if (similarModel != null) {
      similarEntity = MoviesListEntity(
          pageNo: similarModel.pageNo,
          totalPages: similarModel.totalPages,
          movies: similarModel.movies);
    }

    return MovieDetailsEntity(
        backdropPath: movieDetails.backdropPath,
        posterPath: movieDetails.posterPath,
        title: movieDetails.title,
        voteAverage: movieDetails.voteAverage,
        voteCount: movieDetails.voteCount,
        genres: movieDetails.genres,
        overview: movieDetails.overview,
        collection: movieDetails.collection,
        credits: credits,
        images: images,
        videos: videos,
        releaseDate: DateUtl.formatDate(movieDetails.releaseDate),
        language: LangUtl.formatLanguage(movieDetails.language),
        budget: _formatBudgetOrRevenue(movieDetails.budget.toString()),
        revenue: _formatBudgetOrRevenue(movieDetails.revenue.toString()),
        productionCompanies: movieDetails.productionCompanies,
        recommendedMovies: recommendedEntity,
        similarMovies: similarEntity);
  }

  String _formatBudgetOrRevenue(String value) {
    if (value != '0') {
      double digitValue = double.parse(value);

      bool isMillion = false;

      if (value.length > 6) {
        isMillion = true;
        digitValue = digitValue / 1000000;
      }

      String formattedValue = digitValue.toString();

      var parts = formattedValue.split('.');
      String secondValue = parts[1];
      for (int i = 0; i < secondValue.length; i++) {
        if (secondValue.length > 2) {
          secondValue =
              (double.parse(secondValue) / 10).roundToDouble().toString();
        }
      }
      formattedValue = parts[0] + '.' + secondValue;
      while (formattedValue.endsWith('0') || formattedValue.endsWith('.')) {
        formattedValue = formattedValue.substring(0, formattedValue.length - 1);
      }

      if (isMillion) {
        formattedValue = formattedValue + ' Million';
      }

      return '\$' + formattedValue;
    } else {
      return value;
    }
  }
}
