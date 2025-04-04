import 'package:flutter/foundation.dart';

final class AdUtils {
  static const _TEST_BANNER_AD = 'ca-app-pub-3940256099942544/6300978111';
  static const _TEST_INTERSTITIAL_AD = 'ca-app-pub-3940256099942544/1033173712';

  static String bannerAdId(String adId) => kDebugMode ? _TEST_BANNER_AD : adId;
  static String interstitialAdId(String adId) =>
      kDebugMode ? _TEST_INTERSTITIAL_AD : adId;
}
