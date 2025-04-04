import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/celebrities/data/data_sources/celebrities_local_data_source.dart';
import 'package:tmdb/features/main/celebrities/data/data_sources/celebrities_remote_data_source.dart';
import 'package:tmdb/features/main/celebrities/domain/repositories/celebrities_repo.dart';

final class CelebritiesRepoImpl implements CelebritiesRepo {
  final CelebritiesLocalDataSource _localDataSource;
  final CelebritiesRemoteDataSource _remoteDataSource;

  const CelebritiesRepoImpl(this._localDataSource, this._remoteDataSource);

  @override
  Stream<CelebsTableData?> get watchCelebs => _localDataSource.watchCelebs;

  @override
  Future<void> get loadCelebrities async {
    final celebsModel = await _remoteDataSource.loadCelebrities;
    return _localDataSource.cacheData(celebsModel);
  }
}
