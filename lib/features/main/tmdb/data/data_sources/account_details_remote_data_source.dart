import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/tmdb/data/function_params/account_details_cf_params.dart';
import 'package:tmdb/features/main/tmdb/data/function_params/account_details_cf_params_data.dart';
import 'package:tmdb/features/main/tmdb/data/models/account_details_model.dart';

abstract class AccountDetailsRemoteDataSource {
  Future<AccountDetailsModel> loadAccountDetails(String sessionId);
}

final class AccountDetailsRemoteDataSourceImpl
    implements AccountDetailsRemoteDataSource {
  final HttpsCallable _function;

  const AccountDetailsRemoteDataSourceImpl(this._function);

  @override
  Future<AccountDetailsModel> loadAccountDetails(String sessionId) async {
    final data = await CloudFunctionsUtl.call(
      _function,
      AccountDetailsCFParams(
        category: TMDbCFCategory.accountDetails,
        data: AccountDetailsCFParamsData(sessionId: sessionId),
      ).toJson(),
    );
    return AccountDetailsModel.fromJson(data);
  }
}
