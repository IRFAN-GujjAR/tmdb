import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tmdb/models/details/season_details_data.dart';
import 'package:tmdb/utils/utils.dart';


Future<SeasonDetailsData> getSeasonDetails(
    http.Client client, int tvId, int seasonNumber) async {
  final url =
      'https://api.themoviedb.org/3/tv/$tvId/season/$seasonNumber?api_key=$Api_Key&language=en-US';
  var response;
  try{
    response=await client.get(url).timeout(const Duration(seconds: TIME_OUT_DURATION));
  }on Exception{
    return null;
  }
  final parsed = json.decode(response.body);

  return SeasonDetailsData.fromJson(parsed);
}
