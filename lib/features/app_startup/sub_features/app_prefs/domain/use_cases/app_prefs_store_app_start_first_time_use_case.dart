import 'package:tmdb/core/usecase/usecase.dart';

import '../repositories/app_prefs_repo.dart';

final class AppPrefsStoreAppStartFirstTimeUseCase
    implements UseCaseWithoutReturnType<bool> {
  final AppPrefsRepo _repo;

  AppPrefsStoreAppStartFirstTimeUseCase(this._repo);

  @override
  Future<void> call(bool params) => _repo.storeAppStartFirstTime(params);
}
