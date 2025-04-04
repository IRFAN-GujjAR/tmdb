import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/domain/use_cases/params/see_all_tv_shows_params.dart';

import '../repositories/see_all_tv_shows_repo.dart';

final class SeeAllTvShowsUseCase
    implements UseCase<TvShowsListEntity, SeeAllTvShowsParams> {
  final SeeAllTvShowsRepo _repo;

  SeeAllTvShowsUseCase(this._repo);

  @override
  Future<TvShowsListEntity> call(SeeAllTvShowsParams params) =>
      _repo.getTvShows(cfParams: params.cfParams);
}
