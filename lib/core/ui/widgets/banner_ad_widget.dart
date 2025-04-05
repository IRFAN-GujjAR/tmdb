import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';

class BannerAdWidget extends StatefulWidget {
  final String _adUnitId;
  final AdSize _adSize;
  final bool _showDivider;

  const BannerAdWidget({
    Key? key,
    required String adUnitId,
    AdSize adSize = AdSize.banner,
    bool showDivider = false,
  }) : _adUnitId = adUnitId,
       _adSize = adSize,
       _showDivider = showDivider,
       super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late BannerAd _bannerAd;
  bool _showAdd = false;

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: widget._adUnitId,
      size: widget._adSize,
      request: AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) {
          print('Ad loaded.');
          setState(() {
            _showAdd = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Dispose the ad here to free resources.
          ad.dispose();
          print('Ad failed to load: $error');
        },
        // Called when an ad opens an overlay that covers the screen.
        onAdOpened: (Ad ad) => print('Ad opened.'),
        // Called when an ad removes an overlay that covers the screen.
        onAdClosed: (Ad ad) => print('Ad closed.'),
        // Called when an impression occurs on the ad.
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );
    _bannerAd.load();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showAdd
        ? Container(
          alignment: Alignment.center,
          child: AdWidget(ad: _bannerAd),
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
        )
        : widget._showDivider
        ? DividerWidget()
        : Container();
  }
}
