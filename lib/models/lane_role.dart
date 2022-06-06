class LaneRole {
  late final int heroId;
  late final int games;
  late final int laneRole;

  LaneRole.fromJson(Map<String, dynamic> json)
      : heroId = json['hero_id'],
        games = int.parse(json['games']),
        laneRole = json['lane_role'];
}
