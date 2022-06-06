import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/enums/lane_role.dart';

class Hero {
  final num id;
  final String name;
  final Attribute primaryAttribute;
  final String attackType;
  final List<String> roles;
  final int proBan;
  final int proWin;
  final int proPick;

  final num proPickPercent;
  final num proBanPercent;
  final num proWinPercent;
  LaneRole? laneRole;
  final String urlImg;

  String get laneRoleDescription {
    if (laneRole == LaneRole.mid) return "Mid";
    if (laneRole == LaneRole.safe) return "Safe";
    if (laneRole == LaneRole.off) return "Offlane";
    if (laneRole == LaneRole.jungle) return "Jungle";
    return "";
  }

  Hero({
    required this.id,
    required this.name,
    required this.primaryAttribute,
    required this.attackType,
    required this.roles,
    required this.proBan,
    required this.proWin,
    required this.proPick,
    required this.proPickPercent,
    required this.proBanPercent,
    required this.proWinPercent,
    required this.urlImg,
    this.laneRole,
  });
}
