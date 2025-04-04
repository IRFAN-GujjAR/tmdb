import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/data/data_sources/tv_show_season_details_data_source.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/tv_show_season_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/repositories/tv_show_season_details_repo.dart';

final class TvShowSeasonDetailsRepoImpl implements TvShowSeasonDetailsRepo {
  final TvShowSeasonDetailsDataSource _dataSource;

  TvShowSeasonDetailsRepoImpl(this._dataSource);

  @override
  Future<TvShowSeasonDetailsEntity> loadSeasonDetails({
    required int tvId,
    required int seasonNo,
  }) async {
    final seasonDetailsModel = await _dataSource.loadSeasonDetails(
      tvId: tvId,
      seasonNo: seasonNo,
    );
    return TvShowSeasonDetailsEntity(
      name: seasonDetailsModel.name,
      airDate: seasonDetailsModel.airDate,
      overview: seasonDetailsModel.overview,
      posterPath: seasonDetailsModel.posterPath,
      episodes: seasonDetailsModel.episodes,
    );
  }
}
