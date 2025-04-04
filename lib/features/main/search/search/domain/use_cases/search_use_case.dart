import 'package:tmdb/core/entities/search/searches_entity.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/search/search/domain/repositories/search_repo.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';

final class SearchUseCase implements UseCase<SearchesEntity, SearchParams> {
  final SearchRepo _repo;

  SearchUseCase(this._repo);

  @override
  Future<SearchesEntity> call(SearchParams params) => _repo.search(params);
}
