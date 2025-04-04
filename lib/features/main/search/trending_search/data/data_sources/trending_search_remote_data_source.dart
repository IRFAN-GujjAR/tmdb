import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/search/trending_search/data/function_params/trending_search_cf_params.dart';

import '../../../../../../core/models/search/searches_model.dart';

abstract class TrendingSearchRemoteDataSource {
  Future<SearchesModel> get trendingSearch;
}

final class TrendingSearchRemoteDataSourceImpl
    implements TrendingSearchRemoteDataSource {
  final HttpsCallable _function;

  TrendingSearchRemoteDataSourceImpl(this._function);

  @override
  Future<SearchesModel> get trendingSearch async {
    final data = await CloudFunctionsUtl.call(
      _function,
      TrendingSearchCFParams(category: SearchCFCategory.trending).toJson(),
    );
    return SearchesModel.fromJson(data);
  }
}
