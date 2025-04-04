import 'package:equatable/equatable.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/ads/admob_ids_model.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/app_version_model.dart';

final class RemoteConfigModel extends Equatable {
  final AppVersionModel appVersion;
  final AdmobIdsModel admobIds;

  const RemoteConfigModel({required this.appVersion, required this.admobIds});

  @override
  List<Object?> get props => [appVersion, admobIds];
}
