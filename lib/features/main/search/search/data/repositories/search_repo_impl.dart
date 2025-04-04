import 'package:tmdb/core/entities/search/search_entity.dart';
import 'package:tmdb/core/entities/search/searches_entity.dart';
import 'package:tmdb/features/main/search/search/data/data_sources/search_data_source.dart';
import 'package:tmdb/features/main/search/search/domain/repositories/search_repo.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';

final class SearchRepoImpl implements SearchRepo {
  final SearchDataSource _dataSource;

  SearchRepoImpl(this._dataSource);

  @override
  Future<SearchesEntity> search(SearchParams params) async {
    final searchesModel = await _dataSource.search(params);
    final searchesEntity = SearchesEntity(
        searches: searchesModel.searches
            .map((e) => SearchEntity(searchTitle: e.searchTitle))
            .toList());
    return searchesEntity;
  }
}
