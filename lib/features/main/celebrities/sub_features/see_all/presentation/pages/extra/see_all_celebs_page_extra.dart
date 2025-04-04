import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';

final class SeeAllCelebsPageExtra {
  final String pageTitle;
  final CelebritiesListEntity celebsList;
  final Map<String, dynamic> cfParams;

  const SeeAllCelebsPageExtra({
    required this.pageTitle,
    required this.celebsList,
    required this.cfParams,
  });
}
