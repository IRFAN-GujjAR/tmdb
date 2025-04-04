import 'package:tmdb/core/usecase/usecase.dart';

import '../entities/app_prefs_entity.dart';
import '../repositories/app_prefs_repo.dart';

final class AppPrefsLoadValuesUseCase
    implements UseCaseWithoutAsyncAndParams<AppPrefsEntity> {
  final AppPrefsRepo _repo;

  AppPrefsLoadValuesUseCase(this._repo);

  @override
  AppPrefsEntity get call => _repo.getPreferences;
}
