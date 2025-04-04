import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/ads/admob_ids_model.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/remote_config_model.dart';

import '../../../../../../core/firebase/remote_config/firebase_remote_config_utils.dart';
import '../models/app_version_model.dart';

abstract class RemoteConfigDataSource {
  Future<RemoteConfigModel> get loadRemoteConfig;
}

final class RemoteConfigDataSourceImpl implements RemoteConfigDataSource {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigDataSourceImpl(this._remoteConfig);

  @override
  Future<RemoteConfigModel> get loadRemoteConfig async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final installedVersion = packageInfo.version;
    await _remoteConfig.fetchAndActivate();
    final appVersionJson =
        jsonDecode(
              _remoteConfig.getString(
                FirebaseRemoteConfigUtils.appVersionParam,
              ),
            )
            as Map<String, dynamic>;
    appVersionJson.addAll({'installed_version': installedVersion});
    final appVersion = AppVersionModel.fromJson(appVersionJson);

    final admobIdsJson =
        jsonDecode(
              _remoteConfig.getString(FirebaseRemoteConfigUtils.admobIdsParam),
            )
            as Map<String, dynamic>;
    final admobIds = AdmobIdsModel.fromJson(admobIdsJson);

    return RemoteConfigModel(appVersion: appVersion, admobIds: admobIds);
  }
}
