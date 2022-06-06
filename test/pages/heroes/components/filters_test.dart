import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/filters.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: filters', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => HeroesBloc(
          fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
          fetchMetaLanesRolesRepository: HeroMock().makeMockFetchLanesRolesRepository(),
        ),
        child: const Filters(),
      )),
    );

    expect(find.byType(NameFilter), findsOneWidget);
    expect(find.byType(AttributeFilter), findsOneWidget);
  });
}
