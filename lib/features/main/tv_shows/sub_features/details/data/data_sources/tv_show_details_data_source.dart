import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/data/function_params/tv_show_details_cf_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/data/function_params/tv_show_details_cf_params_data.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/data/models/tv_show_details_model.dart';

abstract class TvShowDetailsDataSource {
  Future<TvShowDetailsModel> loadTvShowDetails(int tvId);
}

final class TvShowDetailsDataSourceImpl implements TvShowDetailsDataSource {
  final HttpsCallable _function;

  TvShowDetailsDataSourceImpl(this._function);

  @override
  Future<TvShowDetailsModel> loadTvShowDetails(int tvId) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      TvShowDetailsCFParams(
        category: TvShowsCFCategory.details,
        data: TvShowDetailsCFParamsData(tvId: tvId),
      ).toJson(),
    );
    return TvShowDetailsModel.fromJson(data);
  }
}
