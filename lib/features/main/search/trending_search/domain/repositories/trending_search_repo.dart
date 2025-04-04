import 'package:tmdb/core/database/app_database.dart';

abstract class TrendingSearchRepo {
  Stream<TrendingSearchTableData?> get watchTrendingSearch;
  Future<void> get loadTrendingSearch;
}
