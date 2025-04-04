import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/ads_manager/data/data_sources/ads_manager_data_source.dart';
import 'package:tmdb/features/ads_manager/domain/repositories/ads_manager_repo.dart';

final class AdsManagerRepoImpl implements AdsManagerRepo {
  final AdsManagerDataSource _dataSource;

  const AdsManagerRepoImpl(this._dataSource);

  @override
  Future<void> updateCounter(int count) => _dataSource.updateCounter(count);

  @override
  Stream<AdsManagerTableData?> get watchFunctionCounter =>
      _dataSource.watchFunctionCounter;
}
