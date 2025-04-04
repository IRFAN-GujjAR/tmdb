import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/entities/tmdb_media_list_entity.dart';

abstract class TMDbMediaListRepo {
  Future<TMDbMediaListEntity> loadMediaList(
    TMDbMediaListCfParamsData cfParamsData,
  );
}
