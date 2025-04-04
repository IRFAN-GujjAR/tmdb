import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/ads/banner_ads_model.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/ads/interstitial_ads_model.dart';

part 'admob_ids_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class AdmobIdsModel extends Equatable {
  @JsonKey(name: 'banner_ads')
  final BannerAdsModel bannerAds;
  @JsonKey(name: 'interstitial_ads')
  final InterstitialAdsModel interstitialAds;

  const AdmobIdsModel({required this.bannerAds, required this.interstitialAds});

  factory AdmobIdsModel.fromJson(Map<String, dynamic> json) =>
      _$AdmobIdsModelFromJson(json);

  @override
  List<Object?> get props => [bannerAds, interstitialAds];
}
