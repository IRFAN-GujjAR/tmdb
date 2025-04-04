import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/remote_config_entity.dart';

abstract class RemoteConfigRepo {
  Future<RemoteConfigEntity> get loadRemoteConfig;
}
