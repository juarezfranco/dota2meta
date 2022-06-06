import 'package:cached_network_image/cached_network_image.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/hero_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget hero page components: hero image', (WidgetTester tester) async {
    final hero =
        (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => HeroBloc(
          hero: hero,
          fetchMetaItemsForHeroRepository:
          HeroMock().makeMockFetchMetaItemsForHeroRepository(),
        ),
        child: HeroImage(hero),
      )),
    );

    final imageFinder = find.byType(CachedNetworkImage);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    final image = tester.firstWidget<CachedNetworkImage>(imageFinder);
    expect(image.imageUrl, hero.urlImg);
  });
}
