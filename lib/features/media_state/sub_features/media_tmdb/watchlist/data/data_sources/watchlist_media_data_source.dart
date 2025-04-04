import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/function_params/media_watchlist_cf_params.dart';
import 'package:tmdb/features/media_state/sub_features/media_tmdb/watchlist/data/function_params/media_watchlist_cf_params_data.dart';

import '../../../../../../../core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import '../../../../../../../core/firebase/cloud_functions/cloud_functions_utl.dart';
import '../models/watchlist_media_model.dart';
import '../models/watchlist_media_result_model.dart';

abstract class WatchlistMediaDataSource {
  Future<WatchlistMediaResultModel> set({
    required int userId,
    required String sessionId,
    required WatchlistMediaModel watchlistMedia,
  });
}

final class WatchlistMediaDataSourceImpl implements WatchlistMediaDataSource {
  final HttpsCallable _function;

  const WatchlistMediaDataSourceImpl(this._function);

  @override
  Future<WatchlistMediaResultModel> set({
    required int userId,
    required String sessionId,
    required WatchlistMediaModel watchlistMedia,
  }) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      MediaWatchlistCFParams(
        category: TMDbCFCategory.mediaWatchlist,
        data: MediaWatchlistCFParamsData(
          sessionId: sessionId,
          body: watchlistMedia,
        ),
      ).toJson(),
    );
    return WatchlistMediaResultModel.fromJson(data);
  }
}
