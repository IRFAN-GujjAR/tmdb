import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/bloc/home/celebrities/see_all/see_all_celebrities_events.dart';
import 'package:tmdb/models/celebrities_list.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/repositories/home/celebrities/celebrities_utils_repo.dart';

class SeeAllCelebritiesRepo extends BaseRepo {
  SeeAllCelebritiesRepo({@required Client client}) : super(client);

  Future<CelebritiesList> loadMoreCelebrities(
      LoadMoreSeeAllCelebrities event) async {
    try {
      final newCelebrities = await CelebritiesUtilsRepo.getCategoryCelebrities(
          client: client, url: event.url);
      return CelebritiesList(
          pageNumber: newCelebrities.pageNumber,
          totalPages: newCelebrities.totalPages,
          celebrities: event.previousCelebrities.celebrities +
              newCelebrities.celebrities);
    } catch (error) {
      throw error;
    }
  }
}
