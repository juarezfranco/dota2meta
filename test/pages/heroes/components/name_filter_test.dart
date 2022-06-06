import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: name filter',
          (WidgetTester tester) async {
        final heroBloc = HeroesBloc(
          fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
          fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
        );

        await tester.pumpWidget(
          wrapWithMaterialAppAndScaffold(BlocProvider.value(
            value: heroBloc,
            child: const NameFilter(),
          )),
        );

        final textFieldFinder = find.byType(TextField);
        expect(textFieldFinder, findsOneWidget);

        const inputText = "text example";
        const debounceTime = 500;
        await tester.enterText(textFieldFinder, inputText);
        await tester.pump(const Duration(milliseconds: debounceTime-1));
        expect(heroBloc.state.queryString.isEmpty, isTrue); // debounce is running

        await tester.pump(const Duration(milliseconds: 1)); // wait debounce complete
        expect(heroBloc.state.queryString, equals(inputText));
      });
}
