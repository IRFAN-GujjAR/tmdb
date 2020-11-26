import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/details/season_details_data.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class SeasonDetailsRepo extends BaseRepo {
  SeasonDetailsRepo({@required Client client}) : super(client);

  Future<SeasonDetailsData> loadSeasonDetails(
      int tvId, int seasonNumber, int page) async {
    try {
      final json = await ApiProvider.get(
          url: URLS.seasonDetails(tvId, seasonNumber, page),
          httpClient: client);
      return SeasonDetailsData.fromJson(json);
    } catch (error) {
      throw error;
    }
  }
}
