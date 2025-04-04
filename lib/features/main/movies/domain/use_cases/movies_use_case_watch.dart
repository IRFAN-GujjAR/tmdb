import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/main/movies/domain/repositories/movies_repo.dart';

final class MoviesUseCaseWatch
    implements UseCaseWithoutAsyncAndParams<Stream<MoviesTableData?>> {
  final MoviesRepo _repo;

  MoviesUseCaseWatch(this._repo);

  @override
  Stream<MoviesTableData?> get call => _repo.watchMovies;
}
