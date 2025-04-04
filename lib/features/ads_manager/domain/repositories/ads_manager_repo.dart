import 'package:tmdb/core/database/app_database.dart';

abstract class AdsManagerRepo {
  Stream<AdsManagerTableData?> get watchFunctionCounter;
  Future<void> updateCounter(int count);
}
