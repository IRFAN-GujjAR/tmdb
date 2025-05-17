import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/interstitial_ad_function_call_entity.dart';

part 'interstitial_ad_function_call_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class InterstitialAdFunctionCallModel
    extends InterstitialAdFunctionCallEntity {
  const InterstitialAdFunctionCallModel({
    required super.id,
    required super.idIOS,
    required super.callWaitCount,
  });

  factory InterstitialAdFunctionCallModel.fromJson(Map<String, dynamic> json) =>
      _$InterstitialAdFunctionCallModelFromJson(json);
}
