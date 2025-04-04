import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/entities/movie_collection_details_entity.dart';

import '../repositories/movie_collection_details_repo.dart';

final class MovieCollectionDetailsUseCase
    implements UseCase<MovieCollectionDetailsEntity, int> {
  final MovieCollectionDetailsRepo _repo;

  MovieCollectionDetailsUseCase(this._repo);

  @override
  Future<MovieCollectionDetailsEntity> call(int collectionId) =>
      _repo.getCollectionDetails(collectionId);
}
