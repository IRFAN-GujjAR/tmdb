import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/ads/banner_ads_entity.dart';

part 'banner_ads_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class BannerAdsModel extends BannerAdsEntity {
  BannerAdsModel({
    required super.moviesId,
    required super.moviesIdIOS,
    required super.tvShowsId,
    required super.tvShowsIdIOS,
    required super.celebsId,
    required super.celebsIdIOS,
    required super.searchId,
    required super.searchIdIOS,
    required super.tmdbId,
    required super.tmdbIdIOS,
  });

  factory BannerAdsModel.fromJson(Map<String, dynamic> json) =>
      _$BannerAdsModelFromJson(json);
}
