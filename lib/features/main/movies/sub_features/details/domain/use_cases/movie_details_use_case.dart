import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/entities/movie_details_entity.dart';
import 'package:tmdb/features/main/movies/sub_features/details/domain/repositories/movie_details_repo.dart';

final class MovieDetailsUseCase implements UseCase<MovieDetailsEntity, int> {
  final MovieDetailsRepo _repo;

  MovieDetailsUseCase(this._repo);

  @override
  Future<MovieDetailsEntity> call(int movieId) =>
      _repo.loadMovieDetails(movieId);
}
