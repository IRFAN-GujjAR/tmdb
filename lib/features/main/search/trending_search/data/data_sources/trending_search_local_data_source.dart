import 'package:drift/drift.dart';
import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/models/search/searches_model.dart';
import 'package:tmdb/features/main/search/trending_search/data/db/dao/trending_search_dao.dart';

abstract class TrendingSearchLocalDataSource {
  Stream<TrendingSearchTableData?> get watchTrendingSearches;
  Future<void> cacheData(SearchesModel trendingSearch);
}

final class TrendingSearchLocalDataSourceImpl
    implements TrendingSearchLocalDataSource {
  final TrendingSearchDao _dao;

  const TrendingSearchLocalDataSourceImpl(this._dao);

  @override
  Future<void> cacheData(SearchesModel trendingSearch) => _dao.updateSearches(
    TrendingSearchTableCompanion(
      id: Value(0),
      trendingSearch: Value(trendingSearch),
    ),
  );

  @override
  Stream<TrendingSearchTableData?> get watchTrendingSearches =>
      _dao.watchSearches();
}
