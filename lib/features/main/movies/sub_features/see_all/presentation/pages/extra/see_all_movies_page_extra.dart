import '../../../../../../../../core/entities/movie/movies_list_entity.dart';

final class SeeAllMoviesPageExtra {
  final String pageTitle;
  final MoviesListEntity moviesList;
  final Map<String, dynamic> cfParams;

  SeeAllMoviesPageExtra({
    required this.pageTitle,
    required this.moviesList,
    required this.cfParams,
  });
}
