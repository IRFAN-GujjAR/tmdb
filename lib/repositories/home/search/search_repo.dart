import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class SearchRepo extends BaseRepo {
  SearchRepo({@required Client client}) : super(client);

  Future<List<String>> search(String query, int page) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.search(query, page), httpClient: client);
      final List<String> searches = json['results'].map<String>((json) {
        String mediaType = json['media_type'] as String;
        if (mediaType == 'movie') {
          return json['title'] as String;
        } else {
          return json['name'] as String;
        }
      }).toList();
      return searches;
    } catch (error) {
      throw error;
    }
  }
}
