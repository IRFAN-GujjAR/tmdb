import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/entities/movie_collection_details_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/domain/repositories/movie_collection_details_repo.dart';

import '../data_sources/movie_collection_details_data_source.dart';

final class MovieCollectionDetailsRepoImpl
    implements MovieCollectionDetailsRepo {
  final MovieCollectionDetailsDataSource _dataSource;

  MovieCollectionDetailsRepoImpl(this._dataSource);

  @override
  Future<MovieCollectionDetailsEntity> getCollectionDetails(
    int collectionId,
  ) async {
    final movieCollectionDetailsModel = await _dataSource.getCollectionDetails(
      collectionId,
    );
    return MovieCollectionDetailsEntity(
      name: movieCollectionDetailsModel.name,
      overview: movieCollectionDetailsModel.overview,
      posterPath: movieCollectionDetailsModel.posterPath,
      backdropPath: movieCollectionDetailsModel.backdropPath,
      movies: movieCollectionDetailsModel.movies,
    );
  }
}
