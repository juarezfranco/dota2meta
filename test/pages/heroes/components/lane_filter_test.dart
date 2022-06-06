import 'package:dota2meta/enums/lane_role.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/lane_filter.dart';
import 'package:dota2meta/pages/heroes/components/lane_radio_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: lane filter',
      (WidgetTester tester) async {
    const laneFilter = LaneFilter();

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        BlocProvider(
          create: (context) => HeroesBloc(
            fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
            fetchMetaLanesRolesRepository:
                HeroMock().makeMockFetchLanesRolesRepository(),
          ),
          child: laneFilter,
        ),
      ),
    );

    final laneFilterRadioFinder = find.descendant(
      of: find.byWidget(laneFilter),
      matching: find.byType(LaneRadioFilter),
    );
    final radioFinder = find.descendant(
      of: laneFilterRadioFinder,
      matching: find.byType(Radio<LaneRole>),
    );

    expect(radioFinder, findsNWidgets(4));
    final radios = tester.widgetList<Radio<LaneRole>>(radioFinder).toList();
    expect(radios[0].value, LaneRole.safe);
    expect(radios[1].value, LaneRole.mid);
    expect(radios[2].value, LaneRole.off);
    expect(radios[3].value, LaneRole.jungle);
  });
}
