part of 'heroes_bloc.dart';

@immutable
abstract class HeroesEvent {}

class HeroesStarted extends HeroesEvent {}

class HeroesFetched extends HeroesEvent {}

class HeroesAttributeFiltered extends HeroesEvent {
  final Attribute attribute;

  HeroesAttributeFiltered(this.attribute);
}

class HeroesLaneFiltered extends HeroesEvent {
  final enum_lane_role.LaneRole lane;

  HeroesLaneFiltered(this.lane);
}

class HeroesFilterReseted extends HeroesEvent {}

class HeroesQueryStringChanged extends HeroesEvent {
  final String queryString;

  HeroesQueryStringChanged(this.queryString);
}