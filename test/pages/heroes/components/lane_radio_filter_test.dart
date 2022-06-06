import 'package:dota2meta/enums/lane_role.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/lane_radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: lane radio filter', (WidgetTester tester) async {
    final heroBloc = HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => heroBloc,
        child: const LaneRadioFilter(LaneRole.mid),
      )),
    );

    final radioFinder = find.byType(Radio<LaneRole>);
    expect(radioFinder, findsOneWidget);

    expect(heroBloc.state.selectedLane, isNull);
    await tester.tap(radioFinder);
    expect(heroBloc.state.selectedLane, equals(LaneRole.mid));
  });
}
