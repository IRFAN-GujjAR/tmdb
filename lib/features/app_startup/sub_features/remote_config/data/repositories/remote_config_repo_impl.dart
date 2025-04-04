import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/admob_ids_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/interstitial_ads_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/remote_config_entity.dart';

import '../../domain/repositories/remote_config_repo.dart';
import '../data_sources/remote_config_data_source.dart';

final class RemoteConfigRepoImpl implements RemoteConfigRepo {
  final RemoteConfigDataSource _dataSource;

  RemoteConfigRepoImpl(this._dataSource);

  @override
  Future<RemoteConfigEntity> get loadRemoteConfig async {
    final model = await _dataSource.loadRemoteConfig;
    return RemoteConfigEntity(
      appVersion: model.appVersion,
      admobIds: AdmobIdsEntity(
        bannerAds: model.admobIds.bannerAds,
        interstitialAds: InterstitialAdsEntity(
          functionCall: model.admobIds.interstitialAds.functionCall,
        ),
      ),
    );
  }
}
