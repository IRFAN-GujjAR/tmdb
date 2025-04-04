import 'package:tmdb/core/entities/tv_show/tv_shows_list_entity.dart';

final class SeeAllTvShowsPageExtra {
  final String pageTitle;
  final TvShowsListEntity tvShowsList;
  final Map<String, dynamic> cfParams;

  const SeeAllTvShowsPageExtra({
    required this.pageTitle,
    required this.tvShowsList,
    required this.cfParams,
  });
}
