part of 'hero_bloc.dart';

enum HeroStatus { initial, loading, success, failure }

@immutable
class HeroState {
  final Map<GamePhase, List<Item>> itemsByGamePhase;
  final HeroStatus status;
  final String? errorMessage;

  const HeroState({
    required this.itemsByGamePhase,
    required this.status,
    this.errorMessage,
  });

  const HeroState.initial({
    this.itemsByGamePhase = const {},
    this.status = HeroStatus.initial,
    this.errorMessage,
  });

  HeroState copyWith({
    Map<GamePhase, List<Item>>? itemsByGamePhase,
    HeroStatus? status,
    String? errorMessage,
  }) {
    return HeroState(
      itemsByGamePhase: itemsByGamePhase ?? this.itemsByGamePhase,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
