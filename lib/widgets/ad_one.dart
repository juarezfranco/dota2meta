import 'package:dota2meta/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdOne extends StatefulWidget {
  const AdOne({Key? key}) : super(key: key);

  @override
  State<AdOne> createState() => _AdOneState();
}

class _AdOneState extends State<AdOne> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  void loadAd() {
    _nativeAd = NativeAd(
      adUnitId: Constants.admobId1,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint('$NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Dispose the ad here to free resources.
          debugPrint('$NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _nativeAdIsLoaded ? 100 : null,
      child: _nativeAdIsLoaded ?  AdWidget(
        ad: _nativeAd!,
      ) : null,
    );
  }
}
