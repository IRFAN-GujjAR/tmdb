import 'package:tmdb/core/ui/theme/theme_utils.dart';

import '../../domain/repositories/app_prefs_repo.dart';
import '../data_sources/app_prefs_data_source.dart';
import '../models/app_prefs_model.dart';

final class AppPrefsRepoImpl implements AppPrefsRepo {
  final AppPrefsDataSource _dataSource;

  AppPrefsRepoImpl(this._dataSource);

  @override
  AppPrefsModel get getPreferences => _dataSource.getPreferences;

  @override
  Future<void> storeAppStartFirstTime(bool value) =>
      _dataSource.storeAppStartFirstTime(value);

  @override
  Future<void> storeAppTheme(AppThemes appTheme) =>
      _dataSource.storeAppTheme(appTheme);
}
