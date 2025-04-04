import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/media_state/domain/entities/media_state_entity.dart';
import 'package:tmdb/features/media_state/domain/repositories/media_state_repo.dart';

import '../../data/function_params/media_state_cf_params_data.dart';

final class MediaStateUseCase
    implements UseCase<MediaStateEntity, MediaStateCFParamsData> {
  final MediaStateRepo _repo;

  MediaStateUseCase(this._repo);

  @override
  Future<MediaStateEntity> call(MediaStateCFParamsData params) =>
      _repo.loadMediaState(cfParamsData: params);
}
