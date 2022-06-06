import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/hero_mock.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  blocTest<HeroesBloc, HeroesState>(
    'Initial state',
    build: () => HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    ),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.status, HeroesStatus.initial);
      expect(state.heroes.length, 0);
      expect(state.errorMessage, null);
    },
  );

  blocTest<HeroesBloc, HeroesState>(
    'Stated, ensure load heroes',
    build: () => HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    ),
    act: (bloc) => bloc.add(HeroesStarted()),
    verify: (bloc) {
      final state = bloc.state;
      expect(3, state.heroes.length);
    },
  );

  blocTest<HeroesBloc, HeroesState>(
    'Filter by query string: XXX',
    build: () => HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    )..add(HeroesStarted()),
    act: (bloc) => bloc.add(HeroesQueryStringChanged("XXX")),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.status, HeroesStatus.success);
      expect(state.queryString, "XXX");
      expect(state.filteredHeroes.length, 0);
    },
  );

  blocTest<HeroesBloc, HeroesState>(
    'Filter by query string: axe',
    build: () => HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    ),
    act: (bloc) => bloc
      ..add(HeroesStarted())
      ..add(HeroesQueryStringChanged("axe")),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.queryString, "axe");
      expect(state.filteredHeroes.length, 1);
    },
  );

  blocTest<HeroesBloc, HeroesState>(
    'Filter by attribute',
    build: () => HeroesBloc(
      fetchHeroRepository: HeroMock().makeMockFetchHeroRepository(),
      fetchMetaLanesRolesRepository:
          HeroMock().makeMockFetchLanesRolesRepository(),
    )..add(HeroesStarted()),
    act: (bloc) => bloc.add(HeroesAttributeFiltered(Attribute.agility)),
    verify: (bloc) {
      final state = bloc.state;
      expect(state.selectedAttribute, Attribute.agility);
      expect(state.filteredHeroes.length, 1);
    },
  );
}
