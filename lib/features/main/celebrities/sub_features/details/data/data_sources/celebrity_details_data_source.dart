import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/celebs/celebs_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/function_params/celeb_details_cf_params.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/function_params/celeb_details_cf_params_data.dart';
import 'package:tmdb/features/main/celebrities/sub_features/details/data/models/celebrity_details_model.dart';

abstract class CelebritiesDetailsDataSource {
  Future<CelebrityDetailsModel> loadDetails({required int celebId});
}

final class CelebritiesDetailsDataSourceImpl
    implements CelebritiesDetailsDataSource {
  final HttpsCallable _function;

  CelebritiesDetailsDataSourceImpl(this._function);

  @override
  Future<CelebrityDetailsModel> loadDetails({required int celebId}) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      CelebDetailsCfParams(
        category: CelebsCFCategory.details,
        data: CelebDetailsCfParamsData(celebId),
      ).toJson(),
    );
    return CelebrityDetailsModel.fromJson(data);
  }
}
