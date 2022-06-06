import 'package:dota2meta/models/lane_role.dart';

abstract class FetchMetaLanesRolesRepository {
  Future<List<LaneRole>> fetchMetaLanesRoles(int lane);
}