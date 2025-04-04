import 'package:tmdb/core/usecase/usecase.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/remote_config_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/repositories/remote_config_repo.dart';

final class RemoteConfigUseCase
    implements UseCaseWithoutParams<RemoteConfigEntity> {
  final RemoteConfigRepo _repo;

  RemoteConfigUseCase(this._repo);

  @override
  Future<RemoteConfigEntity> get call => _repo.loadRemoteConfig;
}
