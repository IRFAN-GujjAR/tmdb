import 'package:tmdb/features/main/search/details/domain/entities/search_details_entity.dart';

abstract class SearchDetailsRepo {
  Future<SearchDetailsEntity> loadDetails(String query);
}
