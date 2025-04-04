import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/tv_shows/data/data_sources/tv_shows_local_data_source.dart';
import 'package:tmdb/features/main/tv_shows/data/data_sources/tv_shows_remote_data_source.dart';
import 'package:tmdb/features/main/tv_shows/domain/repositories/tv_shows_repo.dart';

final class TVShowsRepoImpl implements TvShowsRepo {
  final TvShowsLocalDataSource _localDataSource;
  final TvShowsRemoteDataSource _remoteDataSource;

  const TVShowsRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> get loadTvShows async {
    final model = await _remoteDataSource.loadTvShows;
    return _localDataSource.cacheData(model);
  }

  @override
  Stream<TvShowsTableData?> get watchTvShows => _localDataSource.watchTvShows;
}
