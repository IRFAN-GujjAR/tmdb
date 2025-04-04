import '../../../../../core/database/app_database.dart';

abstract class CelebritiesRepo {
  Stream<CelebsTableData?> get watchCelebs;
  Future<void> get loadCelebrities;
}
