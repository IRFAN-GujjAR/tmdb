import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/tv_shows/data/function_params/tv_shows_cf_params.dart';
import 'package:tmdb/features/main/tv_shows/data/models/tv_shows_model.dart';

abstract class TvShowsRemoteDataSource {
  Future<TvShowsModel> get loadTvShows;
}

final class TvShowsRemoteDataSourceImpl extends TvShowsRemoteDataSource {
  final HttpsCallable _function;

  TvShowsRemoteDataSourceImpl(this._function);

  @override
  Future<TvShowsModel> get loadTvShows async {
    final data = await CloudFunctionsUtl.call(
      _function,
      TvShowsCFParams(category: TvShowsCFCategory.home).toJson(),
    );
    return TvShowsModel.fromJson(data);
  }
}
