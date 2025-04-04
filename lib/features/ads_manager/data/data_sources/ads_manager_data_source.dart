import 'package:drift/drift.dart';
import 'package:tmdb/features/ads_manager/data/db/dao/ads_manager_dao.dart';

import '../../../../core/database/app_database.dart';

abstract class AdsManagerDataSource {
  Stream<AdsManagerTableData?> get watchFunctionCounter;
  Future<void> updateCounter(int count);
}

final class AdsManagerDataSourceImpl implements AdsManagerDataSource {
  final AdsManagerDao _dao;

  const AdsManagerDataSourceImpl(this._dao);

  @override
  Future<void> updateCounter(int count) => _dao.updateCounter(
    AdsManagerTableCompanion(id: Value(0), functionCallCount: Value(count)),
  );

  @override
  Stream<AdsManagerTableData?> get watchFunctionCounter => _dao.watchCounter;
}
