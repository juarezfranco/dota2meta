import 'dart:io';

import 'package:dota2meta/pages/heroes/heroes_page.dart';
import 'package:dota2meta/support/app_theme.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
