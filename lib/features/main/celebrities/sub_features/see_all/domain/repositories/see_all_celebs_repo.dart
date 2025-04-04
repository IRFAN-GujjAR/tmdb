import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';

abstract class SeeAllCelebsRepo {
  Future<CelebritiesListEntity> loadCelebs({
    required Map<String, dynamic> cfParams,
  });
}
