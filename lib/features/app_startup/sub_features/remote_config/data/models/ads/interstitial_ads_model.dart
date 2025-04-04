import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/data/models/ads/interstitial_ad_function_call_model.dart';

part 'interstitial_ads_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class InterstitialAdsModel extends Equatable {
  @JsonKey(name: 'function_call')
  final InterstitialAdFunctionCallModel functionCall;

  const InterstitialAdsModel({required this.functionCall});

  factory InterstitialAdsModel.fromJson(Map<String, dynamic> json) =>
      _$InterstitialAdsModelFromJson(json);

  @override
  List<Object?> get props => [functionCall];
}
