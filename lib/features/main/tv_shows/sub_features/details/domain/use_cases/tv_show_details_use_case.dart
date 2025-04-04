


import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/entities/tv_show_details_entity.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/domain/repositories/tv_show_details_repo.dart';

final class TvShowDetailsUseCase implements UseCase<TvShowDetailsEntity,int>{
  final TvShowDetailsRepo _repo;

  TvShowDetailsUseCase(this._repo);

  @override
  Future<TvShowDetailsEntity> call(int tvId)=>_repo.loadTvShowDetails(tvId);

}