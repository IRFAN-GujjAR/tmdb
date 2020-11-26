import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/details/collection_details_data.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class CollectionDetailsRepo extends BaseRepo {
  CollectionDetailsRepo({@required Client client}) : super(client);

  Future<CollectionDetailsData> loadCollectionDetails(
      int movieId, int page) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.collectionDetails(movieId, page), httpClient: client);
      return CollectionDetailsData.fromJson(json);
    } catch (error) {
      throw error;
    }
  }
}
