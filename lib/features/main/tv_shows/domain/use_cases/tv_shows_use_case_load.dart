import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tv_shows/domain/repositories/tv_shows_repo.dart';

final class TvShowsUseCaseLoad implements UseCaseWithoutParamsAndReturnType {
  final TvShowsRepo _repo;

  const TvShowsUseCaseLoad(this._repo);

  @override
  Future<void> get call => _repo.loadTvShows;
}
