import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params.dart';
import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params_data.dart';
import 'package:tmdb/features/media_state/data/models/media_state_model.dart';

abstract class MediaStateDataSource {
  Future<MediaStateModel> loadMediaState({
    required MediaStateCFParamsData cfParamsData,
  });
}

final class MediaStateDataSourceImpl implements MediaStateDataSource {
  final HttpsCallable _function;

  MediaStateDataSourceImpl(this._function);

  @override
  Future<MediaStateModel> loadMediaState({
    required MediaStateCFParamsData cfParamsData,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      MediaStateCFParams(
        category: TMDbCFCategory.mediaState,
        data: cfParamsData,
      ).toJson(),
    );
    return MediaStateModel.fromJson(data);
  }
}
