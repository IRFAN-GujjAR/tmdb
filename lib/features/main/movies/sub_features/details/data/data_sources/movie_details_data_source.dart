import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/function_params/movie_details_cf_params_data.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/function_params/movies_details_cf_params.dart';
import 'package:tmdb/features/main/movies/sub_features/details/data/models/movie_details_model.dart';

abstract class MovieDetailsDataSource {
  Future<MovieDetailsModel> loadMovieDetails(int movieId);
}

final class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
  final HttpsCallable _function;

  MovieDetailsDataSourceImpl(this._function);

  @override
  Future<MovieDetailsModel> loadMovieDetails(int movieId) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      MovieDetailsCFParams(
        category: MoviesCFCategory.details,
        data: MovieDetailsCFParamsData(movieId: movieId),
      ).toJson(),
    );
    return MovieDetailsModel.fromJson(data);
  }
}
