import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tv_shows/tv_shows_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/function_params/season_cf_params.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/function_params/season_cf_params_data.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/models/tv_show_season_details_model.dart';

abstract class TvShowSeasonDetailsDataSource {
  Future<TvShowSeasonDetailsModel> loadSeasonDetails({
    required int tvId,
    required int seasonNo,
  });
}

final class TvShowSeasonDetailsDataSourceImpl
    implements TvShowSeasonDetailsDataSource {
  final HttpsCallable _function;

  TvShowSeasonDetailsDataSourceImpl(this._function);

  @override
  Future<TvShowSeasonDetailsModel> loadSeasonDetails({
    required int tvId,
    required int seasonNo,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      SeasonCFParams(
        category: TvShowsCFCategory.season,
        data: SeasonCFParamsData(tvId: tvId, seasonNo: seasonNo),
      ).toJson(),
    );
    return TvShowSeasonDetailsModel.fromJson(data);
  }
}
