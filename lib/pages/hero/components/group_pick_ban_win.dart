import 'package:dota2meta/pages/hero/components/percent_pick_ban_win.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;

class GroupPickBanWin extends StatelessWidget {
  final model_hero.Hero hero;
  final _statsWidth = 90.0;

  const GroupPickBanWin(this.hero, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(
              width: _statsWidth,
              child: PercentPickBanWin(
                percent: hero.proPickPercent,
                total: hero.proPick,
              ),
            ),
            Text(
              AppLocalizations.of(context).pick,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: _statsWidth,
              child: PercentPickBanWin(
                percent: hero.proBanPercent,
                total: hero.proBan,
              ),
            ),
            Text(
              AppLocalizations.of(context).ban,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: _statsWidth,
              child: PercentPickBanWin(
                percent: hero.proWinPercent,
                total: hero.proWin,
              ),
            ),
            Text(
              AppLocalizations.of(context).win,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ],
    );
  }
}
