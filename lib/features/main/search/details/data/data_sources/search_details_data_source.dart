import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_details_cf_params.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_details_cf_params_data.dart';
import 'package:tmdb/features/main/search/details/data/models/search_details_model.dart';

abstract class SearchDetailsDataSource {
  Future<SearchDetailsModel> loadDetails(String query);
}

final class SearchDetailsDataSourceImpl implements SearchDetailsDataSource {
  final HttpsCallable _function;

  SearchDetailsDataSourceImpl(this._function);

  @override
  Future<SearchDetailsModel> loadDetails(String query) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      SearchDetailsCFParams(
        category: SearchCFCategory.details,
        data: SearchDetailsCFParamsData(query: query, pageNo: 1),
      ).toJson(),
    );
    return SearchDetailsModel.fromJson(data);
  }
}
