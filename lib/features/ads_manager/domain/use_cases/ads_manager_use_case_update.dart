import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/ads_manager/domain/repositories/ads_manager_repo.dart';

final class AdsManagerUseCaseUpdate extends UseCaseWithoutReturnType<int> {
  final AdsManagerRepo _repo;

  AdsManagerUseCaseUpdate(this._repo);

  @override
  Future<void> call(int params) => _repo.updateCounter(params);
}
