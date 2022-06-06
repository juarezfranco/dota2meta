import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/models/hero.dart';
import 'package:dota2meta/models/item.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/support/app_http_client.dart';
import 'package:meta/meta.dart';

part 'hero_event.dart';

part 'hero_state.dart';

class HeroBloc extends Bloc<HeroEvent, HeroState> {
  final Hero hero;
  final FetchMetaItemsForHeroRepository fetchMetaItemsForHeroRepository;

  HeroBloc({
    required this.hero,
    required this.fetchMetaItemsForHeroRepository,
  }) : super(const HeroState.initial()) {
    on<HeroStarted>((event, emit) async {
      emit(state.copyWith(
        status: HeroStatus.loading,
      ));

      try {
        final itemsByGamePhase =
            await fetchMetaItemsForHeroRepository.fetchMetaItemsForHero(hero);

        emit(state.copyWith(
          status: HeroStatus.success,
          itemsByGamePhase: itemsByGamePhase,
        ));
      } on HttpRequestError catch (e) {
        emit(state.copyWith(
          status: HeroStatus.failure,
          errorMessage: e.message,
        ));
      }
    });
  }
}
