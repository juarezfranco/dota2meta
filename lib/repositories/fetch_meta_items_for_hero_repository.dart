import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/item.dart';

abstract class FetchMetaItemsForHeroRepository {
  Future<Map<GamePhase, List<Item>>> fetchMetaItemsForHero(Hero hero);
}