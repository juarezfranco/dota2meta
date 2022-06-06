import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget wrapWithMaterialAppAndScaffold(Widget widget) {
  return wrapWithMaterialApp(
    Scaffold(
      body: widget,
    ),
  );
}

Widget wrapWithMaterialApp(Widget widget) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: widget,
  );
}
