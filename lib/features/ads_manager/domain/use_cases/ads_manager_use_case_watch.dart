import 'package:tmdb/core/database/app_database.dart';
import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/ads_manager/domain/repositories/ads_manager_repo.dart';

final class AdsManagerUseCaseWatch
    extends UseCaseWithoutAsyncAndParams<Stream<AdsManagerTableData?>> {
  final AdsManagerRepo _repo;

  AdsManagerUseCaseWatch(this._repo);

  @override
  Stream<AdsManagerTableData?> get call => _repo.watchFunctionCounter;
}
