import '../../../../../../../core/entities/movie/movies_list_entity.dart';

abstract class SeeAllMoviesRepo {
  Future<MoviesListEntity> getMovies({required Map<String, dynamic> cfParams});
}
