import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/models/details/collection_details_data.dart';
import 'package:tmdb/utils/utils.dart';

Future<CollectionDetailsData> getCollectionDetails(
    http.Client client, int movieId) async {
  final url =
      'https://api.themoviedb.org/3/collection/$movieId?api_key=$Api_Key&language=en-US';

  var response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  final parsed = json.decode(response.body);
  return CollectionDetailsData.fromJson(parsed);
}
