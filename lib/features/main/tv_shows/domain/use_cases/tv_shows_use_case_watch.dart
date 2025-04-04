import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/tv_shows/domain/repositories/tv_shows_repo.dart';

final class TvShowsUseCaseWatch
    implements UseCaseWithoutAsyncAndParams<Stream<TvShowsTableData?>> {
  final TvShowsRepo _repo;

  const TvShowsUseCaseWatch(this._repo);

  @override
  Stream<TvShowsTableData?> get call => _repo.watchTvShows;
}
