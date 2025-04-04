import '../../../../../core/database/app_database.dart';

abstract class MoviesRepo {
  Future<void> get loadMovies;
  Stream<MoviesTableData?> get watchMovies;
}
