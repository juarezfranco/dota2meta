import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';


void main() {
  testWidgets('Widget heroes components: attribute filter',
      (WidgetTester tester) async {
    const attributeFilter = AttributeFilter();

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => HeroesBloc(
          fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
          fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
        ),
        child: attributeFilter,
      )),
    );

    final attributeFilterRadioFinder = find.descendant(
      of: find.byWidget(attributeFilter),
      matching: find.byType(AttributeRadioFilter),
    );
    final radioFinder = find.descendant(
      of: attributeFilterRadioFinder,
      matching: find.byType(Radio<Attribute>),
    );

    expect(radioFinder, findsNWidgets(3));
    final radios = tester.widgetList<Radio<Attribute>>(radioFinder).toList();
    expect(radios[0].value, Attribute.strength);
    expect(radios[1].value, Attribute.agility);
    expect(radios[2].value, Attribute.intelligence);
  });
}
