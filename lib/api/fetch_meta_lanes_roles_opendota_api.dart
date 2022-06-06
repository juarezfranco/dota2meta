import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/lane_role.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';

class FetchMetaLanesRolesOpendotaApi extends FetchMetaLanesRolesRepository {
  final AppHttpClient httpClient;

  FetchMetaLanesRolesOpendotaApi(this.httpClient);

  @override
  Future<List<LaneRole>> fetchMetaLanesRoles(int lane) {
    return httpClient.get<List<LaneRole>>(
      'https://api.opendota.com/api/scenarios/laneRoles?lane_role=$lane',
      cache: const Duration(hours: 24),
      parse: (data) => (data as List)
          .map<LaneRole>((jsonItem) => LaneRole.fromJson(jsonItem))
          .toList(),
    );
  }
}
