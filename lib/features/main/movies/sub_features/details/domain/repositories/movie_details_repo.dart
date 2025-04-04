import 'package:tmdb/features/main/movies/sub_features/details/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepo {
  Future<MovieDetailsEntity> loadMovieDetails(int movieId);
}
