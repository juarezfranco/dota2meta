import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/hero_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Widget heroes components: hero filter button',
      (WidgetTester tester) async {

    final heroesBloc = HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        BlocProvider.value(
          value: heroesBloc,
          child: const HeroFilterButton(),
        ),
      ),
    );

    final iconBtnFinder = find.byType(IconButton);
    expect(iconBtnFinder, findsOneWidget);
    final iconBtn = tester.firstWidget<IconButton>(iconBtnFinder);
    expect(iconBtn.icon is LineIcon, isTrue,
        reason: "expect a icon of type LineIcon");
    expect((iconBtn.icon as LineIcon).icon == LineIcons.filter, isTrue);
  });
}
