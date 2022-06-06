import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/item.dart';
import 'package:dota2meta/repositories/fetch_all_items_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';

class FetchMetaItemsForHeroOpendotaApi extends FetchMetaItemsForHeroRepository {
  final AppHttpClient httpClient;
  final FetchAllItemsRepository fetchAllItemsRepository;

  FetchMetaItemsForHeroOpendotaApi(
    this.httpClient, {
    required this.fetchAllItemsRepository,
  });

  @override
  Future<Map<GamePhase, List<Item>>> fetchMetaItemsForHero(Hero hero) async {
    final items = await fetchAllItemsRepository.fetchAllItems();

    return await httpClient.get<Map<GamePhase, List<Item>>>(
      'https://api.opendota.com/api//heroes/${hero.id}/itemPopularity',
      cache: const Duration(hours: 24),
      parse: (data) => {
        GamePhase.start: (data["start_game_items"] as Map)
            .keys
            .map<Item>((itemId) => items.firstWhere((i) => i.id == int.parse(itemId)))
            .toList(),
        GamePhase.early: (data["early_game_items"] as Map)
            .keys
            .map<Item>((itemId) => items.firstWhere((i) => i.id == int.parse(itemId)))
            .toList(),
        GamePhase.mid: (data["mid_game_items"] as Map)
            .keys
            .map<Item>((itemId) => items.firstWhere((i) => i.id == int.parse(itemId)))
            .toList(),
        GamePhase.late: (data["late_game_items"] as Map)
            .keys
            .map<Item>((itemId) => items.firstWhere((i) => i.id == int.parse(itemId)))
            .toList(),
      },
    );
  }
}
