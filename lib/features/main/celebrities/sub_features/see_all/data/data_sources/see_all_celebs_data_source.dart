import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/core/models/celebs/celebrities_list_model.dart';

abstract class SeeAllCelebsDataSource {
  Future<CelebritiesListModel> loadCelebs({
    required Map<String, dynamic> cfParams,
  });
}

final class SeeAllCelebsDataSourceImpl implements SeeAllCelebsDataSource {
  final HttpsCallable _function;

  SeeAllCelebsDataSourceImpl(this._function);

  @override
  Future<CelebritiesListModel> loadCelebs({
    required Map<String, dynamic> cfParams,
  }) async {
    final data = await CloudFunctionsUtl.call(_function, cfParams);
    return CelebritiesListModel.fromJson(data);
  }
}
