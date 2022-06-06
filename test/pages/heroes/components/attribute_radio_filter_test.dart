import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: attribute radio filter', (WidgetTester tester) async {
    final heroBloc = HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => heroBloc,
        child: const AttributeRadioFilter(Attribute.strength),
      )),
    );

    final radioFinder = find.byType(Radio<Attribute>);
    expect(radioFinder, findsOneWidget);

    expect(heroBloc.state.selectedAttribute, isNull);
    await tester.tap(radioFinder);
    expect(heroBloc.state.selectedAttribute, equals(Attribute.strength));
  });
}
