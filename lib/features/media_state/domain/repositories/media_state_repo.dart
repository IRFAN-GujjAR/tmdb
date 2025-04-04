import 'package:tmdb/features/media_state/domain/entities/media_state_entity.dart';

import '../../data/function_params/media_state_cf_params_data.dart';

abstract class MediaStateRepo {
  Future<MediaStateEntity> loadMediaState({
    required MediaStateCFParamsData cfParamsData,
  });
}
