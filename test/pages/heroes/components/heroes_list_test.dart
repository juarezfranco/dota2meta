import 'package:bloc_test/bloc_test.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/heroes_list.dart';
import 'package:dota2meta/widgets/error_with_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';
import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: heroes list with completed',
      (WidgetTester tester) async {
    final heroBloc = HeroMock().makeMockHeroesBloc();
    const heroesList = HeroesList();
    const stateInitial = HeroesState.initial();
    final heroes = await HeroMock().makeHeoresList();
    final stateCompleted = HeroesState(
      status: HeroesStatus.success,
      heroes: heroes,
      filteredHeroes: heroes,
    );

    whenListen<HeroesState>(
      heroBloc,
      Stream.value(stateCompleted),
      initialState: stateInitial,
    );
    expect(heroBloc.state, equals(stateInitial));

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => heroBloc,
        child: heroesList,
      )),
    );

    heroBloc.emit(stateCompleted);
    await tester.pump();
    expect(find.byType(ErrorWithRetry), findsNothing);
    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
    final listView = tester.firstWidget<ListView>(listViewFinder);
    expect(listView.childrenDelegate is SliverChildBuilderDelegate, isTrue);
    expect(
      (listView.childrenDelegate as SliverChildBuilderDelegate).childCount,
      equals(heroes.length),
    );
  });

  testWidgets('Widget heroes components: heroes list with loading',
      (WidgetTester tester) async {
    final heroBloc = HeroMock().makeMockHeroesBloc();
    const heroesList = HeroesList();

    const stateInitial = HeroesState.initial();
    const stateInProgress = HeroesState(
      status: HeroesStatus.loading,
      heroes: [],
      filteredHeroes: [],
      errorMessage: "Has error",
    );

    whenListen<HeroesState>(
      heroBloc,
      Stream.value(stateInProgress),
      initialState: stateInitial,
    );
    expect(heroBloc.state, equals(stateInitial));

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => heroBloc,
        child: heroesList,
      )),
    );

    heroBloc.emit(stateInProgress);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Widget heroes components: heroes list with failure',
      (WidgetTester tester) async {
    final heroBloc = HeroMock().makeMockHeroesBloc();
    const heroesList = HeroesList();

    const stateInitial = HeroesState.initial();

    const stateFailure = HeroesState(
      status: HeroesStatus.failure,
      heroes: [],
      filteredHeroes: [],
      errorMessage: "Has error",
    );

    whenListen<HeroesState>(
      heroBloc,
      Stream.value(stateFailure),
      initialState: stateInitial,
    );
    expect(heroBloc.state, equals(stateInitial));

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(BlocProvider(
        create: (context) => heroBloc,
        child: heroesList,
      )),
    );

    heroBloc.emit(stateFailure);
    await tester.pump();

    // show error
    expect(find.byType(ErrorWithRetry), findsOneWidget);
    final errorFinder = find.descendant(
      of: find.byWidget(heroesList),
      matching: find.byType(ErrorWithRetry),
    );

    // ensure show error message of state
    final messageFinder = find.descendant(
      of: errorFinder,
      matching: find.text("Has error"),
    );
    expect(messageFinder, findsOneWidget);
  });
}
