import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/entities/tmdb_media_list_entity.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/repositories/tmdb_media_list_repo.dart';

final class TMDbMediaListUseCase
    implements UseCase<TMDbMediaListEntity, TMDbMediaListCfParamsData> {
  final TMDbMediaListRepo _repo;

  const TMDbMediaListUseCase(this._repo);

  @override
  Future<TMDbMediaListEntity> call(TMDbMediaListCfParamsData params) =>
      _repo.loadMediaList(params);
}
