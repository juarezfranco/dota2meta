import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      width: 350,
      child: Text(
        AppLocalizations.of(context).infoHeroesSection,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
