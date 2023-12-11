import 'package:dota2meta/config.dart';
import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';

num kHeroesByMatch = 10;

class FetchHeroOpendotaApi extends FetchAllHeroesRepository {
  final AppHttpClient httpClient;

  FetchHeroOpendotaApi(this.httpClient);

  @override
  Future<List<Hero>> fetchAllHeroes() {
    return httpClient.get<List<Hero>>(
      '${Config.hostOpendotaApi}/api/heroStats',
      cache: const Duration(hours: 24),
      parse: (data) {
        // sum all matches
        num totalMatches = 0;

        for (var item in data) {
          totalMatches += item['pro_pick'] ?? 0;
        }
        totalMatches = (totalMatches / kHeroesByMatch).ceil();

        return (data as List).map<Hero>(
          (jsonItem) {
            final nameCdn = jsonItem['name'].replaceAll("npc_dota_hero_", "");

            // calculate percentage picks/bans/wins based in opendota statistics
            final picks = jsonItem['pro_pick'] ?? 0;
            final wins = jsonItem['pro_win'] ?? 0;
            final bans = jsonItem['pro_ban'] ?? 0;
            final proPickPercent = totalMatches == 0 ? 0 : picks * 100 / totalMatches;
            final proWinPercent = picks == 0 ? 0 : wins * 100 / picks;
            final proBanPercent = totalMatches == 0 ? 0 : bans * 100 / totalMatches;

            return Hero(
              id: jsonItem["id"],
              name: jsonItem['localized_name'],
              primaryAttribute: {
                "agi": Attribute.agility,
                "str": Attribute.strength,
                "int": Attribute.intelligence,
                "all": Attribute.universal,
              }[jsonItem['primary_attr']]!,
              attackType: jsonItem['attack_type'],
              roles: jsonItem['roles'].cast<String>(),
              proBan: jsonItem['pro_ban'] ?? 0,
              proWin: jsonItem['pro_win'] ?? 0,
              proPick: jsonItem['pro_pick'] ?? 0,
              proPickPercent: proPickPercent,
              proBanPercent: proBanPercent,
              proWinPercent: proWinPercent,
              urlImg: "https://steamcdn-a.akamaihd.net/apps/dota2/images/dota_react/heroes/$nameCdn.png",
            );
          },
        ).toList();
      },
    );
  }
}
