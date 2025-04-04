import 'package:equatable/equatable.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/interstitial_ad_function_call_entity.dart';

final class InterstitialAdsEntity extends Equatable {
  final InterstitialAdFunctionCallEntity functionCall;

  const InterstitialAdsEntity({required this.functionCall});

  @override
  List<Object?> get props => [functionCall];
}
