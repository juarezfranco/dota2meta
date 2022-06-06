import 'package:cached_network_image/cached_network_image.dart';
import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/hero_image.dart';
import 'package:dota2meta/pages/hero/components/item_image.dart';
import 'package:dota2meta/widgets/image_with_shadow.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget hero page components: item image',
      (WidgetTester tester) async {
    final hero =
        (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;
    final fetchMetaItemsRepository =
        HeroMock().makeMockFetchMetaItemsForHeroRepository();
    final item = (await fetchMetaItemsRepository
            .fetchMetaItemsForHero(hero))[GamePhase.early]!
        .first;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => HeroBloc(
          hero: hero,
          fetchMetaItemsForHeroRepository: fetchMetaItemsRepository,
        ),
        child: ItemImage(item),
      )),
    );

    final imageFinder = find.byType(ImageWithShadow);
    expect(find.byType(ImageWithShadow), findsOneWidget);
    final image = tester.firstWidget<ImageWithShadow>(imageFinder);
    expect(image.url, item.urlImg);
  });
}
