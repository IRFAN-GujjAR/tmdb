import 'package:equatable/equatable.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/interstitial_ads_entity.dart';

import 'banner_ads_entity.dart';

final class AdmobIdsEntity extends Equatable {
  final BannerAdsEntity bannerAds;
  final InterstitialAdsEntity interstitialAds;

  const AdmobIdsEntity({
    required this.bannerAds,
    required this.interstitialAds,
  });

  @override
  List<Object?> get props => [bannerAds, interstitialAds];
}
