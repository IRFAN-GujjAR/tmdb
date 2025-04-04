import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/movies/sub_features/see_all/domain/repositories/see_all_movies_repo.dart';

import 'params/see_all_movies_params.dart';

final class SeeAllMoviesUseCase
    implements UseCase<MoviesListEntity, SeeAllMoviesParams> {
  final SeeAllMoviesRepo _repo;

  SeeAllMoviesUseCase(this._repo);

  @override
  Future<MoviesListEntity> call(SeeAllMoviesParams params) =>
      _repo.getMovies(cfParams: params.cfParams);
}
