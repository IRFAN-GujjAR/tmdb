import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/models/search/searches_model.dart';
import 'package:tmdb/features/main/search/search/data/function_params/search_cf_params.dart';
import 'package:tmdb/features/main/search/search/data/function_params/search_cf_params_data.dart';
import 'package:tmdb/features/main/search/search/domain/use_cases/params/search_params.dart';

abstract class SearchDataSource {
  Future<SearchesModel> search(SearchParams params);
}

final class SearchDataSourceImpl implements SearchDataSource {
  final HttpsCallable _function;

  SearchDataSourceImpl(this._function);

  @override
  Future<SearchesModel> search(SearchParams params) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      SearchCFParams(
        category: SearchCFCategory.multiSearch,
        data: SearchCFParamsData(query: params.query, pageNo: params.pageNo),
      ).toJson(),
    );
    return SearchesModel.fromJson(data);
  }
}
