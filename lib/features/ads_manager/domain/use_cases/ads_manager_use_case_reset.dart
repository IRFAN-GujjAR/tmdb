import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/ads_manager/domain/repositories/ads_manager_repo.dart';

final class AdsManagerUseCaseReset extends UseCaseWithoutParamsAndReturnType {
  final AdsManagerRepo _repo;

  AdsManagerUseCaseReset(this._repo);

  @override
  Future<void> get call => _repo.updateCounter(0);
}
