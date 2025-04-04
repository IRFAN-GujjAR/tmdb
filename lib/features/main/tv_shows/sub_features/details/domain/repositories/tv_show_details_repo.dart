import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/entities/tv_show_details_entity.dart';

abstract class TvShowDetailsRepo {
  Future<TvShowDetailsEntity> loadTvShowDetails(int tvId);
}
