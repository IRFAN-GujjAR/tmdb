import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/movies/movies_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/data/function_params/collection_cf_params.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/data/function_params/collection_cf_params_data.dart';
import 'package:tmdb/features/main/movies/sub_features/details/sub_features/collection/data/models/movie_collection_details_model.dart';

abstract class MovieCollectionDetailsDataSource {
  Future<MovieCollectionDetailsModel> getCollectionDetails(int collectionId);
}

final class MovieCollectionDetailsDataSourceImpl
    implements MovieCollectionDetailsDataSource {
  final HttpsCallable _function;

  MovieCollectionDetailsDataSourceImpl(this._function);

  @override
  Future<MovieCollectionDetailsModel> getCollectionDetails(
    int collectionId,
  ) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      CollectionCFParams(
        category: MoviesCFCategory.collection,
        data: CollectionCFParamsData(collectionId),
      ).toJson(),
    );
    return MovieCollectionDetailsModel.fromJson(data);
  }
}
