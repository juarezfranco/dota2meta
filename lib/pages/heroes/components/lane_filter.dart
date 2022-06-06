import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/enums/lane_role.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:dota2meta/pages/heroes/components/lane_radio_filter.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';

class LaneFilter extends StatelessWidget {
  const LaneFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).laneRole),
        const Divider(),
        Column(
          children: const [
            LaneRadioFilter(LaneRole.safe),
            LaneRadioFilter(LaneRole.mid),
            LaneRadioFilter(LaneRole.off),
            LaneRadioFilter(LaneRole.jungle),
          ],
        ),
      ],
    );
  }
}
