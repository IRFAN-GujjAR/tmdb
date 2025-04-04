import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/search/trending_search/domain/repositories/trending_search_repo.dart';

final class TrendingSearchUseCaseLoad
    implements UseCaseWithoutParamsAndReturnType {
  final TrendingSearchRepo _repo;

  TrendingSearchUseCaseLoad(this._repo);

  @override
  Future<void> get call => _repo.loadTrendingSearch;
}
