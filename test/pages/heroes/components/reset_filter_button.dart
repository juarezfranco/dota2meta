import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/enums/lane_role.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/reset_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: reset filter button',
      (WidgetTester tester) async {
    final heroesBloc = HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider.value(
        value: heroesBloc,
        child: const ResetFilterButton(),
      )),
    );
    const filledFilterState = HeroesState(
      status: HeroesStatus.success,
      heroes: [],
      filteredHeroes: [],
      queryString: "test",
      selectedAttribute: Attribute.strength,
      selectedLane: LaneRole.safe,
    );
    heroesBloc.emit(filledFilterState);
    await tester.pump();
    expect(heroesBloc.state.queryString, "test");
    expect(heroesBloc.state.selectedAttribute, Attribute.strength);
    expect(heroesBloc.state.selectedLane, LaneRole.safe);

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);

    expect(heroesBloc.state.queryString, isEmpty);
    expect(heroesBloc.state.selectedAttribute, isNull);
    expect(heroesBloc.state.selectedLane, isNull);
  });
}
