import 'dart:io';

import 'package:dota2meta/pages/heroes/heroes_page.dart';
import 'package:dota2meta/support/app_theme.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    MobileAds.instance.initialize();

    if (kDebugMode) {
      RequestConfiguration configuration = RequestConfiguration(
        testDeviceIds: ["5D22D897343124E2F70D539E7C843B56"],
      );
      MobileAds.instance.updateRequestConfiguration(configuration);
    }
  }

  await Firebase.initializeApp();

  AppContainer.initialize();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dota 2 Meta',
      theme: AppTheme.of(context).theme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HeoresPage(),
    );
  }
}
