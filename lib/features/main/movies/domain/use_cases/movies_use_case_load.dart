import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/movies/domain/repositories/movies_repo.dart';

final class MoviesUseCaseLoad implements UseCaseWithoutParamsAndReturnType {
  final MoviesRepo _repo;

  MoviesUseCaseLoad(this._repo);

  @override
  Future<void> get call => _repo.loadMovies;
}
