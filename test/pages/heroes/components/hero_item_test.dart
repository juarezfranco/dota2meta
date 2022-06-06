import 'package:dota2meta/pages/heroes/components/attribute_label.dart';
import 'package:dota2meta/pages/heroes/components/hero_item.dart';
import 'package:dota2meta/pages/heroes/components/percent_pick_ban_win.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: hero list item',
      (WidgetTester tester) async {
    final hero = (await HeroMock().makeHeoresList()).first;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        HeroItem(
          hero,
          horizontalPadding: 8.0,
          statsWidth: 180,
        ),
      ),
    );

    expect(find.text(hero.name), findsOneWidget);
    expect(find.byType(AttributeLabel), findsOneWidget);
    expect(find.byType(PercentPickBanWin), findsNWidgets(3));
  });
}
