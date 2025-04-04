import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';

abstract class SeeAllTvShowsDataSource {
  Future<TvShowsListModel> getTvShows({required Map<String, dynamic> cfParams});
}

final class SeeAllTvShowsDataSourceImpl implements SeeAllTvShowsDataSource {
  final HttpsCallable _function;

  const SeeAllTvShowsDataSourceImpl(this._function);

  @override
  Future<TvShowsListModel> getTvShows({
    required Map<String, dynamic> cfParams,
  }) async {
    final data = await CloudFunctionsUtl.call(_function, cfParams);
    return TvShowsListModel.fromJson(data);
  }
}
