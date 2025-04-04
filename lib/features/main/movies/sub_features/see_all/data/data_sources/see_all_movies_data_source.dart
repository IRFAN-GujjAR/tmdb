import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/models/movie/movies_list_model.dart';

abstract class SeeAllMoviesDataSource {
  Future<MoviesListModel> getMovies({required Map<String, dynamic> cfParams});
}

final class SeeAllMoviesDataSourceImpl implements SeeAllMoviesDataSource {
  final HttpsCallable _function;

  const SeeAllMoviesDataSourceImpl(this._function);

  @override
  Future<MoviesListModel> getMovies({
    required Map<String, dynamic> cfParams,
  }) async {
    final data = await CloudFunctionsUtl.call(_function, cfParams);
    return MoviesListModel.fromJson(data);
  }
}
