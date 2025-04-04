import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tmdb/features/main/movies/data/db/tables/movies_table.dart';

import '../../features/ads_manager/data/db/tables/ads_manager_table.dart';
import '../../features/main/celebrities/data/db/tables/celebs_table.dart';
import '../../features/main/search/trending_search/data/db/tables/trending_search_table.dart';
import '../../features/main/tv_shows/data/db/tables/tv_shows_table.dart';
import '../models/celebs/celebrities_list_model.dart';
import '../models/movie/movies_list_model.dart';
import '../models/search/searches_model.dart';
import '../models/tv_show/tv_shows_list_model.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    AdsManagerTable,
    MoviesTable,
    TvShowsTable,
    CelebsTable,
    TrendingSearchTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'tmdb_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
