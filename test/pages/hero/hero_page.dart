import 'package:dota2meta/pages/hero/components/group_pick_ban_win.dart';
import 'package:dota2meta/pages/hero/components/hero_image.dart';
import 'package:dota2meta/pages/hero/components/items.dart';
import 'package:dota2meta/pages/hero/components/name_with_icon_attribute.dart';
import 'package:dota2meta/pages/hero/hero_page.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/hero_mock.dart';
import '../../widgets/helpers.dart';


void main() {
  testWidgets('Hero page', (WidgetTester tester) async {
    final hero =
        (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;

    AppContainer.registerFactory<FetchMetaItemsForHeroRepository>(
      (_) => HeroMock().makeMockFetchMetaItemsForHeroRepository(),
    );

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(HeroPage(hero)),
    );

    expect(find.byType(HeroImage), findsOneWidget);
    expect(find.byType(NameWithIconAttribute), findsOneWidget);
    expect(find.byType(GroupPickBanWin), findsOneWidget);
    expect(find.byType(Items), findsOneWidget);
  });
}
