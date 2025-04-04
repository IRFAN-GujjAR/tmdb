import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_names.dart';

import '../../ui/initialize_app.dart';

final class CloudFunctionsUtl {
  static HttpsCallable get moviesFunction =>
      locator.get<HttpsCallable>(instanceName: CloudFunctionsNames.MOVIES);
  static HttpsCallable get tvShowsFunction =>
      locator.get<HttpsCallable>(instanceName: CloudFunctionsNames.TV_SHOWS);
  static HttpsCallable get celebsFunction =>
      locator.get<HttpsCallable>(instanceName: CloudFunctionsNames.CELEBS);
  static HttpsCallable get searchFunction =>
      locator.get<HttpsCallable>(instanceName: CloudFunctionsNames.SEARCH);
  static HttpsCallable get tMDBFunction =>
      locator.get<HttpsCallable>(instanceName: CloudFunctionsNames.TMDb);

  void get initializeSingletons {
    locator.registerSingleton(
      FirebaseFunctions.instance.httpsCallable(CloudFunctionsNames.MOVIES),
      instanceName: CloudFunctionsNames.MOVIES,
    );
    locator.registerSingleton(
      FirebaseFunctions.instance.httpsCallable(CloudFunctionsNames.TV_SHOWS),
      instanceName: CloudFunctionsNames.TV_SHOWS,
    );
    locator.registerSingleton(
      FirebaseFunctions.instance.httpsCallable(CloudFunctionsNames.CELEBS),
      instanceName: CloudFunctionsNames.CELEBS,
    );
    locator.registerSingleton(
      FirebaseFunctions.instance.httpsCallable(CloudFunctionsNames.SEARCH),
      instanceName: CloudFunctionsNames.SEARCH,
    );
    locator.registerSingleton(
      FirebaseFunctions.instance.httpsCallable(CloudFunctionsNames.TMDb),
      instanceName: CloudFunctionsNames.TMDb,
    );
  }

  static call(HttpsCallable function, Map<String, dynamic> params) async {
    final result = await function.call(params);
    return jsonDecode(jsonEncode(result.data));
  }
}
