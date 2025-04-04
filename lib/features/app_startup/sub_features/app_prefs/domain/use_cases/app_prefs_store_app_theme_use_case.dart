import 'package:tmdb/core/ui/theme/theme_utils.dart';
import 'package:tmdb/core/usecase/usecase.dart';

import '../repositories/app_prefs_repo.dart';

final class AppPrefsSaveAppThemeUseCase
    implements UseCaseWithoutReturnType<AppThemes> {
  final AppPrefsRepo _repo;

  AppPrefsSaveAppThemeUseCase(this._repo);

  @override
  Future<void> call(AppThemes appTheme) async => _repo.storeAppTheme(appTheme);
}
