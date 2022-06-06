import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final hero =
      (await HeroMock().makeMockFetchHeroRepository().fetchAllHeroes()).first;

  blocTest<HeroBloc, HeroState>(
    'Initial state',
    build: () => HeroBloc(
      hero: hero,
      fetchMetaItemsForHeroRepository:
          HeroMock().makeMockFetchMetaItemsForHeroRepository(),
    ),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.status, HeroStatus.initial);
      expect(state.itemsByGamePhase.length, 0);
      expect(state.errorMessage, null);
    },
  );

  blocTest<HeroBloc, HeroState>(
    'Started state',
    build: () => HeroBloc(
      hero: hero,
      fetchMetaItemsForHeroRepository:
      HeroMock().makeMockFetchMetaItemsForHeroRepository(),
    )..add(HeroStarted()),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.status, HeroStatus.success);
      expect(state.itemsByGamePhase.length, GamePhase.values.length);
      expect(state.errorMessage, null);
    },
  );
}
