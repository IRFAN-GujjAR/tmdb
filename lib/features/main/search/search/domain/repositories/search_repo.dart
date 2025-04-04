import 'package:tmdb/core/entities/search/searches_entity.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';

abstract class SearchRepo {
  Future<SearchesEntity> search(SearchParams params);
}
