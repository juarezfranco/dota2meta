import 'dart:io';

import 'package:dota2meta/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdOne extends StatefulWidget {
  final double height;

  const AdOne({
    super.key,
    this.height = 80,
  });

  @override
  State<AdOne> createState() => _AdOneState();
}

class _AdOneState extends State<AdOne> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      _loadAd();
    }
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: Constants.admobId1,
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
      ),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            print('$NativeAd loaded.');
          }
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            print('$NativeAd failed to load: $error');
          }
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _nativeAdIsLoaded ? widget.height : null,
      child: _nativeAdIsLoaded
          ? AdWidget(
              ad: _nativeAd!,
            )
          : null,
    );
  }
}
