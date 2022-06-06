import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:dota2meta/pages/heroes/components/attribute_label.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeFilter extends StatelessWidget {
  const AttributeFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).attribute),
        const Divider(),
        Column(
          children: const [
            AttributeRadioFilter(Attribute.strength),
            AttributeRadioFilter(Attribute.agility),
            AttributeRadioFilter(Attribute.intelligence),
          ],
        ),
      ],
    );
  }
}
