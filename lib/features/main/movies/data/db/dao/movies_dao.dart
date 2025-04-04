import 'package:drift/drift.dart';

import '../../../../../../core/database/app_database.dart';
import '../tables/movies_table.dart';

part 'movies_dao.g.dart';

@DriftAccessor(tables: [MoviesTable])
class MoviesDao extends DatabaseAccessor<AppDatabase> with _$MoviesDaoMixin {
  MoviesDao(AppDatabase db) : super(db);

  Future<void> updateMovies(MoviesTableCompanion entry) =>
      into(moviesTable).insertOnConflictUpdate(entry);

  Stream<MoviesTableData?> watchMovies() =>
      select(moviesTable).watchSingleOrNull();
}
