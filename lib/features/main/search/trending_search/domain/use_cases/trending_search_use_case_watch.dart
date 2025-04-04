import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/search/trending_search/domain/repositories/trending_search_repo.dart';

final class TrendingSearchUseCaseWatch
    implements UseCaseWithoutAsyncAndParams<Stream<TrendingSearchTableData?>> {
  final TrendingSearchRepo _repo;

  const TrendingSearchUseCaseWatch(this._repo);

  @override
  Stream<TrendingSearchTableData?> get call => _repo.watchTrendingSearch;
}
