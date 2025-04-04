import 'package:tmdb/features/media_state/data/data_sources/media_state_data_source.dart';
import 'package:tmdb/features/media_state/domain/entities/media_state_entity.dart';
import 'package:tmdb/features/media_state/domain/repositories/media_state_repo.dart';

import '../function_params/media_state_cf_params_data.dart';

final class MediaStateRepoImpl implements MediaStateRepo {
  final MediaStateDataSource _dataSource;

  MediaStateRepoImpl(this._dataSource);

  @override
  Future<MediaStateEntity> loadMediaState({
    required MediaStateCFParamsData cfParamsData,
  }) async {
    final model = await _dataSource.loadMediaState(cfParamsData: cfParamsData);
    return MediaStateEntity(
      id: model.id,
      favorite: model.favorite,
      rated: model.rated,
      watchlist: model.watchlist,
    );
  }
}
