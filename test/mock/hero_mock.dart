import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/item.dart';
import 'package:dota2meta/models/lane_role.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:flutter/services.dart';

Future<List<Hero>> _heroesList() async {
  const path = "test/mock/heroes.json";
  return (jsonDecode(await rootBundle.loadString(path)) as List)
      .map<Hero>((jsonItem) => Hero(
            id: jsonItem["id"],
            name: jsonItem['localized_name'],
            primaryAttribute: {
              "agi": Attribute.agility,
              "str": Attribute.strength,
              "int": Attribute.intelligence,
            }[jsonItem['primary_attr']]!,
            attackType: jsonItem['attack_type'],
            roles: jsonItem['roles'].cast<String>(),
            proBan: jsonItem['pro_ban'] ?? 0,
            proWin: jsonItem['pro_win'] ?? 0,
            proPick: jsonItem['pro_pick'] ?? 0,
            proPickPercent: 0,
            proBanPercent: 0,
            proWinPercent: 0,
            urlImg: "http://example.com",
          ))
      .toList();
}

Future<List<LaneRole>> _lanesRoles() async {
  const path = "test/mock/lanes_roles.json";
  return (jsonDecode(await rootBundle.loadString(path)) as List)
      .map<LaneRole>((itemJson) => LaneRole.fromJson(itemJson))
      .toList();
}

class HeroMock {
  Future<List<Hero>> makeHeoresList() => _heroesList();

  HeroesBloc makeMockHeroesBloc() => _MockHeroesBloc();

  HeroBloc makeMockHeroBloc() => _MockHeroBloc();

  FetchAllHeroesRepository makeMockFetchHeroRepository() =>
      _MockFetchHeroRepository();

  FetchMetaLanesRolesRepository makeMockFetchLanesRolesRepository() =>
      _MockFetchLanesRolesRepository();

  FetchMetaItemsForHeroRepository makeMockFetchMetaItemsForHeroRepository() =>
      _MockFetchMetaItemsForHeroRepository();
}

class _MockHeroesBloc extends MockBloc<HeroesEvent, HeroesState>
    implements HeroesBloc {}

class _MockHeroBloc extends MockBloc<HeroEvent, HeroState> implements HeroBloc {}

class _MockFetchLanesRolesRepository extends FetchMetaLanesRolesRepository {
  @override
  Future<List<LaneRole>> fetchMetaLanesRoles(int lane) => _lanesRoles();
}

class _MockFetchHeroRepository extends FetchAllHeroesRepository {
  _MockFetchHeroRepository();

  @override
  Future<List<Hero>> fetchAllHeroes() => _heroesList();
}

class _MockFetchMetaItemsForHeroRepository
    extends FetchMetaItemsForHeroRepository {
  @override
  Future<Map<GamePhase, List<Item>>> fetchMetaItemsForHero(Hero hero) async {
    return {
      GamePhase.start: [
        const Item(
          id: 1,
          name: "Item 1",
          cost: 100,
          urlImg: "http://example",
        ),
      ],
      GamePhase.early: [
        const Item(
          id: 2,
          name: "Item 2",
          cost: 200,
          urlImg: "http://example",
        ),
      ],
      GamePhase.mid: [
        const Item(
          id: 3,
          name: "Item 3",
          cost: 300,
          urlImg: "http://example",
        ),
      ],
      GamePhase.late: [
        const Item(
          id: 4,
          name: "Item 4",
          cost: 400,
          urlImg: "http://example",
        ),
      ],
    };
  }
}
