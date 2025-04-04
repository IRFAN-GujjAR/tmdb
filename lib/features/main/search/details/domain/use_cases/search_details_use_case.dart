import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/search/details/domain/entities/search_details_entity.dart';
import 'package:tmdb/features/main/search/details/domain/repositories/search_details_repo.dart';

final class SearchDetailsUseCase
    implements UseCase<SearchDetailsEntity, String> {
  final SearchDetailsRepo _repo;

  SearchDetailsUseCase(this._repo);

  @override
  Future<SearchDetailsEntity> call(String query) => _repo.loadDetails(query);
}
