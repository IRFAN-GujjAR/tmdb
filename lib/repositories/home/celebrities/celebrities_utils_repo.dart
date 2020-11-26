import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/celebrities_data.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/network/api_provider.dart';

class CelebritiesUtilsRepo {
  static Future<CelebritiesList> getCategoryCelebrities(
      {@required Client client, @required String url}) async {
    try {
      final json = await ApiProvider.get(url: url, httpClient: client);
      final celebritiesList = CelebritiesList.fromJson(json);
      final correctedCelebrities = getCorrectedCelebrities(celebritiesList);
      return correctedCelebrities;
    } catch (error) {
      throw error;
    }
  }

  static CelebritiesList getCorrectedCelebrities(
      CelebritiesList celebritiesList) {
    if (celebritiesList == null || celebritiesList.celebrities.isEmpty) {
      return CelebritiesList(
          pageNumber: celebritiesList.pageNumber,
          totalPages: celebritiesList.totalPages,
          celebrities: []);
    }

    List<CelebritiesData> deletingCelebrities;

    celebritiesList
      ..celebrities.forEach((celeb) {
        if (celeb.profilePath == null || celeb.knownFor == null) {
          deletingCelebrities == null
              ? deletingCelebrities = [celeb]
              : deletingCelebrities.add(celeb);
        }
      });

    if (deletingCelebrities != null) {
      deletingCelebrities.forEach((celeb) {
        celebritiesList..celebrities.remove(celeb);
      });
    }

    return celebritiesList;
  }
}
