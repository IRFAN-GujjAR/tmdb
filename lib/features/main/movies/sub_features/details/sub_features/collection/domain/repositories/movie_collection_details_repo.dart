import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/entities/movie_collection_details_entity.dart';

abstract class MovieCollectionDetailsRepo {
  Future<MovieCollectionDetailsEntity> getCollectionDetails(int collectionId);
}
