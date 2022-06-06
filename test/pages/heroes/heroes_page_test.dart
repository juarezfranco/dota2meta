import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/filters.dart';
import 'package:dota2meta/pages/heroes/components/heroes_list.dart';
import 'package:dota2meta/pages/heroes/components/info_section.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:dota2meta/pages/heroes/heroes_page.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/hero_mock.dart';
import '../../widgets/helpers.dart';


void main() {
  testWidgets('Heroes page', (WidgetTester tester) async {
    AppContainer.registerFactory<FetchAllHeroesRepository>(
      (_) => HeroMock().makeMockFetchHeroRepository(),
    );
    AppContainer.registerFactory<FetchMetaLanesRolesRepository>(
      (_) => HeroMock().makeMockFetchLanesRolesRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(const HeoresPage()),
    );

    expect(find.byType(InfoSection), findsOneWidget);
    expect(find.byType(HeroesList), findsOneWidget);
  });
}
