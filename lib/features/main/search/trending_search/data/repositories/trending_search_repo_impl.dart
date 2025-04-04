import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/search/trending_search/data/data_sources/trending_search_local_data_source.dart';
import 'package:tmdb/features/main/search/trending_search/data/data_sources/trending_search_remote_data_source.dart';
import 'package:tmdb/features/main/search/trending_search/domain/repositories/trending_search_repo.dart';

final class TrendingSearchRepoImpl implements TrendingSearchRepo {
  final TrendingSearchLocalDataSource _localDataSource;
  final TrendingSearchRemoteDataSource _remoteDataSource;

  TrendingSearchRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<void> get loadTrendingSearch async {
    final trendingSearchesModel = await _remoteDataSource.trendingSearch;
    return _localDataSource.cacheData(trendingSearchesModel);
  }

  @override
  Stream<TrendingSearchTableData?> get watchTrendingSearch =>
      _localDataSource.watchTrendingSearches;
}
