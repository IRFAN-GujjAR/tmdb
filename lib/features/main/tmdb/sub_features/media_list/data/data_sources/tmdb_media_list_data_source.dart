import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/models/tmdb_media_list_model.dart';

abstract class TMDbMediaListDataSource {
  Future<TMDbMediaListModel> loadMediaList(
    TMDbMediaListCfParamsData cfParamsData,
  );
}

final class TMDbMediaListDataSourceImpl implements TMDbMediaListDataSource {
  final HttpsCallable _function;

  const TMDbMediaListDataSourceImpl(this._function);

  @override
  Future<TMDbMediaListModel> loadMediaList(
    TMDbMediaListCfParamsData cfParamsData,
  ) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      TMDbMediaListCfParams(
        category: TMDbCFCategory.mediaList,
        data: cfParamsData,
      ).toJson(),
    );
    return TMDbMediaListModel.fromJson(data);
  }
}
