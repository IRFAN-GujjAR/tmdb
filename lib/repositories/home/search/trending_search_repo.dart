import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class TrendingSearchRepo extends BaseRepo {
  TrendingSearchRepo({@required Client client}) : super(client);

  Future<List<String>> get loadTrendingSearches async {
    try {
      final json = await ApiProvider.get(
          url: URLS.trendingSearches(1), httpClient: client);
      final parsed = json['results'];
      final List<String> trendingSearches = parsed.map<String>((json) {
        String mediaType = json['media_type'] as String;
        if (mediaType == 'movie') {
          return json['title'] as String;
        } else {
          return json['name'] as String;
        }
      }).toList();
      return trendingSearches;
    } catch (error) {
      throw error;
    }
  }
}
