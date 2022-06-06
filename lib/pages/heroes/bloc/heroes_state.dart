part of 'heroes_bloc.dart';

enum HeroesStatus { initial, loading, success, failure }

@immutable
class HeroesState {
  final HeroesStatus status;
  final List<Hero> heroes;
  final List<Hero> filteredHeroes;
  final String? errorMessage;

  // filters
  final Attribute? selectedAttribute;
  final enum_lane_role.LaneRole? selectedLane;
  final String queryString;

  const HeroesState.initial()
      : status = HeroesStatus.initial,
        heroes = const [],
        filteredHeroes = const [],
        errorMessage = null,
        selectedAttribute = null,
        selectedLane = null,
        queryString = "";

  const HeroesState({
    required this.status,
    required this.heroes,
    required this.filteredHeroes,
    this.queryString = "",
    this.errorMessage,
    this.selectedAttribute,
    this.selectedLane,
  });

  HeroesState copyWith({
    HeroesStatus? status,
    List<Hero>? heroes,
    List<Hero>? filteredHeroes,
    String? errorMessage,
    String? queryString,
    Attribute? selectedAttribute,
    enum_lane_role.LaneRole? selectedLane,
    bool resetErrorMessage = false,
    bool resetSelectedAttribute = false,
    bool resetSelectedLane = false,
  }) {
    return HeroesState(
      status: status ?? this.status,
      heroes: heroes ?? this.heroes,
      filteredHeroes: filteredHeroes ?? this.filteredHeroes,
      queryString: queryString ?? this.queryString,
      errorMessage:
          resetErrorMessage ? null : (errorMessage ?? this.errorMessage),
      selectedAttribute: resetSelectedAttribute
          ? null
          : (selectedAttribute ?? this.selectedAttribute),
      selectedLane:
          resetSelectedLane ? null : (selectedLane ?? this.selectedLane),
    );
  }
}
