import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/movies/data/function_params/movies_cf_params.dart';
import 'package:tmdb/features/main/movies/data/models/movies_model.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesModel> get loadMovies;
}

final class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final HttpsCallable _function;

  MoviesRemoteDataSourceImpl(this._function);

  @override
  Future<MoviesModel> get loadMovies async {
    final data = await CloudFunctionsUtl.call(
      _function,
      MoviesCFParams(category: MoviesCFCategory.home).toJson(),
    );
    return MoviesModel.fromJson(data);
  }
}
