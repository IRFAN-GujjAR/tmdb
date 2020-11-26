import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_utils_repo.dart';
import 'package:tmdb/utils/urls.dart';

class CelebritiesRepo extends BaseRepo {
  CelebritiesRepo({@required Client client}) : super(client);

  Future<List<CelebritiesList>> get loadCelebritiesLists async {
    final popularCelebrities =
        await CelebritiesUtilsRepo.getCategoryCelebrities(
            client: client, url: URLS.popularCelebrities(1));
    final trendingCelebrities =
        await CelebritiesUtilsRepo.getCategoryCelebrities(
            client: client, url: URLS.trendingCelebrities(1));
    return [popularCelebrities, trendingCelebrities];
  }
}
