import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/name_with_icon_attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget hero page components: name with icon attribute', (WidgetTester tester) async {
    final hero =
        (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(NameWithIconAttribute(hero)),
    );

    expect(find.text(hero.name), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
