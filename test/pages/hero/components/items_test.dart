import 'package:bloc_test/bloc_test.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/group_pick_ban_win.dart';
import 'package:dota2meta/pages/hero/components/items.dart';
import 'package:dota2meta/pages/hero/components/percent_pick_ban_win.dart';
import 'package:dota2meta/pages/heroes/components/attribute_filter.dart';
import 'package:dota2meta/pages/heroes/components/filters.dart';
import 'package:dota2meta/pages/heroes/components/name_filter.dart';
import 'package:dota2meta/widgets/error_with_retry.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets(
    'Widget hero page components: items - completed',
    (WidgetTester tester) async {
      final hero =
          (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes())
              .first;
      final itemsByGamePhase = (await HeroMock()
          .makeMockFetchMetaItemsForHeroRepository()
          .fetchMetaItemsForHero(hero));
      final heroBloc = HeroMock().makeMockHeroBloc();

      final stateCompleted = HeroState(
        itemsByGamePhase: itemsByGamePhase,
        status: HeroStatus.success,
      );

      whenListen<HeroState>(
        heroBloc,
        Stream.value(stateCompleted),
        initialState: const HeroState.initial(),
      );

      await tester.pumpWidget(
        wrapWithMaterialAppAndScaffold(BlocProvider.value(
          value: heroBloc,
          child: Items(hero),
        )),
      );

      heroBloc.emit(stateCompleted);
      await tester.pump();
      expect(find.byType(ErrorWithRetry), findsNothing);
      expect(find.byType(ItemsByGamePhase),
          findsNWidgets(itemsByGamePhase.length));
    },
  );

  // testWidgets(
  //   'Widget hero page components: items - failure',
  //       (WidgetTester tester) async {
  //     final hero =
  //         (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes())
  //             .first;
  //     final heroBloc = HeroMock().makeMockHeroBloc();
  //
  //     const stateFailure = HeroState(
  //       itemsByGamePhase: {},
  //       status: HeroStatus.failure,
  //       errorMessage: "error message",
  //     );
  //
  //     whenListen<HeroState>(
  //       heroBloc,
  //       Stream.value(stateFailure),
  //       initialState: const HeroState.initial(),
  //     );
  //
  //     await tester.pumpWidget(
  //       wrapWithMaterialAppAndScaffold(BlocProvider.value(
  //         value: heroBloc,
  //         child: Items(hero),
  //       )),
  //     );
  //
  //     heroBloc.emit(stateFailure);
  //     await tester.pump();
  //     expect(find.byType(ErrorWithRetry), findsOneWidget);
  //   },
  // );
  //
  // testWidgets(
  //   'Widget hero page components: items - loading',
  //   (WidgetTester tester) async {
  //     final hero =
  //         (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes())
  //             .first;
  //     final heroBloc = HeroMock().makeMockHeroBloc();
  //
  //     const stateLoading = HeroState(
  //       itemsByGamePhase: {},
  //       status: HeroStatus.loading,
  //     );
  //
  //     whenListen<HeroState>(
  //       heroBloc,
  //       Stream.value(stateLoading),
  //       initialState: HeroState.initial(),
  //     );
  //
  //     await tester.pumpWidget(
  //       wrapWithMaterialAppAndScaffold(BlocProvider.value(
  //         value: heroBloc,
  //         child: Items(hero),
  //       )),
  //     );
  //
  //     heroBloc.emit(stateLoading);
  //     await tester.pump();
  //     expect(find.byType(ErrorWithRetry), findsNothing);
  //     expect(find.byType(CircularProgressIndicator), findsOneWidget);
  //   },
  // );
}
