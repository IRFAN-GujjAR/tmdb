import 'package:equatable/equatable.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/admob_ids_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/app_version_entity.dart';

final class RemoteConfigEntity extends Equatable {
  final AppVersionEntity appVersion;
  final AdmobIdsEntity admobIds;

  const RemoteConfigEntity({required this.appVersion, required this.admobIds});

  @override
  List<Object?> get props => [appVersion, admobIds];
}
