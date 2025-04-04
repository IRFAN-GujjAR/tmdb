import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/features/main/celebrities/data/db/dao/celebs_dao.dart';
import 'package:tmdb/features/main/celebrities/data/models/celebrities_model.dart';

abstract class CelebritiesLocalDataSource {
  Stream<CelebsTableData?> get watchCelebs;
  Future<void> cacheData(CelebritiesModel celebs);
}

final class CelebritiesLocalDataSourceImpl
    implements CelebritiesLocalDataSource {
  final CelebsDao _dao;

  const CelebritiesLocalDataSourceImpl(this._dao);

  @override
  Future<void> cacheData(CelebritiesModel celebs) => _dao.updateCelebs(
    CelebsTableCompanion(
      id: Value(0),
      popular: Value(celebs.popular),
      trending: Value(celebs.trending),
    ),
  );

  @override
  Stream<CelebsTableData?> get watchCelebs => _dao.watchCelebs();
}
