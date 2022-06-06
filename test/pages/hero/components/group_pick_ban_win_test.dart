import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/group_pick_ban_win.dart';
import 'package:dota2meta/pages/hero/components/percent_pick_ban_win.dart';
import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/filters.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget hero page components: group pick ban win', (WidgetTester tester) async {
    final hero =
        (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => HeroBloc(
          hero: hero,
          fetchMetaItemsForHeroRepository:
          HeroMock().makeMockFetchMetaItemsForHeroRepository(),
        ),
        child: GroupPickBanWin(hero),
      )),
    );

    expect(find.byType(PercentPickBanWin), findsNWidgets(3));
  });
}
