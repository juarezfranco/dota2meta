import 'package:bloc/bloc.dart';
import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/enums/lane_role.dart' as enum_lane_role;
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/lane_role.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';
import 'package:meta/meta.dart';

part 'heroes_event.dart';

part 'heroes_state.dart';

class HeroesBloc extends Bloc<HeroesEvent, HeroesState> {
  final FetchAllHeroesRepository fetchHeroRepository;
  final FetchMetaLanesRolesRepository fetchMetaLanesRolesRepository;

  HeroesBloc({
    required this.fetchHeroRepository,
    required this.fetchMetaLanesRolesRepository,
  }) : super(const HeroesState.initial()) {
    on<HeroesStarted>(_fetchHeroesAndEmit);

    on<HeroesFetched>(_fetchHeroesAndEmit);

    on<HeroesQueryStringChanged>((event, emit) {
      final newState = state.copyWith(
        queryString: event.queryString,
      );
      _applyFilterAndEmit(newState, emit);
    });

    on<HeroesFilterReseted>((event, emit) {
      _resetFilterAndEmit(state, emit);
    });

    on<HeroesAttributeFiltered>((event, emit) {
      final HeroesState newState;

      if (event.attribute == state.selectedAttribute) {
        newState = state.copyWith(
          resetSelectedAttribute: true,
        );
      } else {
        newState = state.copyWith(
          selectedAttribute: event.attribute,
        );
      }
      _applyFilterAndEmit(newState, emit);
    });

    on<HeroesLaneFiltered>((event, emit) {
      final HeroesState newState;

      if (event.lane == state.selectedLane) {
        newState = state.copyWith(
          resetSelectedLane: true,
        );
      } else {
        newState = state.copyWith(
          selectedLane: event.lane,
        );
      }
      _applyFilterAndEmit(newState, emit);
    });
  }

  void _resetFilterAndEmit(HeroesState state, Emitter emit) {
    emit(state.copyWith(
      queryString: "",
      resetSelectedAttribute: true,
      resetSelectedLane: true,
      filteredHeroes: [...state.heroes],
    ));
  }

  void _applyFilterAndEmit(HeroesState state, Emitter emit) {
    List<Hero> heroes = [...state.heroes];

    emit(state.copyWith(
      status: HeroesStatus.loading,
    ));

    if (state.queryString.isNotEmpty) {
      heroes = heroes
          .where(
            (h) => h.name.toLowerCase().contains(
                  state.queryString.toLowerCase(),
                ),
          )
          .toList();
    }

    if (state.selectedAttribute != null) {
      heroes = heroes
          .where((h) => h.primaryAttribute == state.selectedAttribute)
          .toList();
    }

    if (state.selectedLane != null) {
      heroes = heroes.where((h) => h.laneRole == state.selectedLane).toList();
    }

    emit(state.copyWith(
      filteredHeroes: heroes,
      status: HeroesStatus.success,
    ));
  }

  Future _fetchHeroesAndEmit(_, Emitter emit) async {
    emit(state.copyWith(
      status: HeroesStatus.loading,
      resetErrorMessage: true,
    ));

    try {
      final heroes = await fetchHeroRepository.fetchAllHeroes();
      final List<LaneRole> lanesRoles = [];
      for (var i = 0; i < 4; i++) {
        lanesRoles.addAll(
          await fetchMetaLanesRolesRepository.fetchMetaLanesRoles(i),
        );
      }

      // sort by popular heroes first
      heroes.sort(
        (a, b) => (a.proPick + a.proBan).compareTo(b.proPick + b.proBan),
      );
      final heroesSorted = heroes.reversed.toList();

      // vincule lanes with hero
      final lanesConvertion = <int, enum_lane_role.LaneRole>{
        1: enum_lane_role.LaneRole.safe,
        2: enum_lane_role.LaneRole.mid,
        3: enum_lane_role.LaneRole.off,
        4: enum_lane_role.LaneRole.jungle,
      };
      for (Hero hero in heroesSorted) {
        // calculate lane more played
        final lanesCount =
            List.generate(5, (index) => 0); // is 5 but alway ignore 0
        for (LaneRole lane in lanesRoles) {
          if (lane.heroId == hero.id) {
            lanesCount[lane.laneRole] += lane.games;
          }
        }

        var largest = 0;
        for (var i = 0; i < lanesCount.length; i++) {
          if (lanesCount[i] >= largest) {
            largest = lanesCount[i];
            hero.laneRole = lanesConvertion[i];
          }
        }
      }
      // end vincule lane with hero

      final newState = state.copyWith(
        status: HeroesStatus.success,
        heroes: heroesSorted,
        filteredHeroes: [...heroesSorted],
        resetErrorMessage: true,
      );
      _applyFilterAndEmit(newState, emit);
    } on HttpRequestError catch (e) {
      emit(state.copyWith(
        status: HeroesStatus.failure,
        errorMessage: e.message,
      ));
    }
  }
}
