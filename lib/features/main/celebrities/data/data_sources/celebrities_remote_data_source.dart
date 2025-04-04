import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/celebrities/data/function_params/celebs_cf_params.dart';
import 'package:tmdb/features/main/celebrities/data/models/celebrities_model.dart';

abstract class CelebritiesRemoteDataSource {
  Future<CelebritiesModel> get loadCelebrities;
}

final class CelebritiesRemoteDataSourceImpl
    implements CelebritiesRemoteDataSource {
  final HttpsCallable _function;

  CelebritiesRemoteDataSourceImpl(this._function);

  @override
  Future<CelebritiesModel> get loadCelebrities async {
    final data = await CloudFunctionsUtl.call(
      _function,
      CelebsCFParams(category: CelebsCFCategory.home).toJson(),
    );
    return CelebritiesModel.fromJson(data);
  }
}
