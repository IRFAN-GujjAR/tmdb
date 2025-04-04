import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/entities/tv_show_season_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/repositories/tv_show_season_details_repo.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/domain/use_cases/params/tv_show_season_details_params.dart';

final class TvShowSeasonDetailsUseCase
    implements UseCase<TvShowSeasonDetailsEntity, TvShowSeasonDetailsParams> {
  final TvShowSeasonDetailsRepo _repo;

  TvShowSeasonDetailsUseCase(this._repo);

  @override
  Future<TvShowSeasonDetailsEntity> call(TvShowSeasonDetailsParams params) =>
      _repo.loadSeasonDetails(tvId: params.tvId, seasonNo: params.seasonNo);
}
