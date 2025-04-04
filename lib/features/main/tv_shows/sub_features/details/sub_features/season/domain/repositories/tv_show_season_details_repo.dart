import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/tv_show_season_details_entity.dart';

abstract class TvShowSeasonDetailsRepo {
  Future<TvShowSeasonDetailsEntity> loadSeasonDetails({
    required int tvId,
    required int seasonNo,
  });
}
