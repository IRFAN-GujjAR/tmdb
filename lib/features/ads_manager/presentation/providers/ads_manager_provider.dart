import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/ads/ad_utils.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/ui_utl.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_bloc.dart';
import 'package:tmdb/features/ads_manager/presentation/blocs/ads_manager_state.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/admob_ids_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/banner_ads_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/remote_config/domain/entities/ads/interstitial_ad_function_call_entity.dart';

import '../blocs/ads_manager_event.dart';

final class AdsManagerProvider extends ChangeNotifier {
  InterstitialAd? _interstitialAd;
  AdmobIdsEntity? _admobIds;
  set setAdmobIds(AdmobIdsEntity value) {
    _admobIds = value;
  }

  BannerAdsEntity? get bannerAds => _admobIds?.bannerAds;
  InterstitialAdFunctionCallEntity? get functionCallAd =>
      _admobIds?.interstitialAds.functionCall;

  bool _isAdLoading = false;
  bool _isAdShowing = false;

  void _loadInterstitialAd(AdsManagerBloc bloc, String adId) {
    InterstitialAd.load(
      adUnitId: AdUtils.interstitialAdId(adId),
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _isAdLoading = false;
          _interstitialAd = ad;
          _isAdShowing = true;
          _showInterstitialAd(bloc, adId);
        },
        onAdFailedToLoad: (LoadAdError error) {
          _isAdLoading = false;
          logger.e("Interstitial Ad failed to load: $error");
          _interstitialAd = null;
        },
      ),
    );
  }

  void _showInterstitialAd(AdsManagerBloc bloc, String adId) {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          UIUtl.hideStatusBar;
        },
        onAdDismissedFullScreenContent: (ad) {
          UIUtl.showStatusBar;
          _isAdShowing = false;
          ad.dispose();
          if (bloc.state.adsManager.functionCallCount >
              functionCallAd!.callWaitCount) {
            bloc.add(const AdsManagerEventReset());
          }
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          UIUtl.showStatusBar;
          _isAdShowing = false;
          ad.dispose();
        },
      );
      _interstitialAd!.show();
    } else {
      logger.d("Interstitial Ad not ready yet.");
    }
  }

  void handleBlocState(AdsManagerBloc bloc, AdsManagerState state) {
    if (state.adsManager.functionCallCount > functionCallAd!.callWaitCount) {
      if (_admobIds != null && !_isAdLoading && !_isAdShowing) {
        _isAdLoading = true;
        _loadInterstitialAd(bloc, functionCallAd!.id);
      }
    }
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }
}
