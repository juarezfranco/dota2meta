import 'package:dota2meta/enums/game_phase.dart';
import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/item_image.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:dota2meta/widgets/error_with_retry.dart';
import 'package:flutter/material.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;
import 'package:flutter_bloc/flutter_bloc.dart';

class Items extends StatelessWidget {
  final model_hero.Hero hero;

  const Items(
    this.hero, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context).items,
            style: Theme.of(context).textTheme.headline6,
          ),
          BlocBuilder<HeroBloc, HeroState>(
            builder: (context, state) {
              if (state.status == HeroStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == HeroStatus.failure) {
                return ErrorWithRetry(
                  message: state.errorMessage!,
                  retryPressed: () => BlocProvider.of<HeroBloc>(context).add(
                    HeroStarted(),
                  ),
                );
              }

              return Column(
                children: GamePhase.values
                    .map<Widget>((phase) => ItemsByGamePhase(phase))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ItemsByGamePhase extends StatelessWidget {
  final GamePhase gamePhase;

  const ItemsByGamePhase(this.gamePhase, {super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final title = {
      GamePhase.start: locale.startGame,
      GamePhase.early: locale.earlyGame,
      GamePhase.mid: locale.midGame,
      GamePhase.late: locale.lateGame,
    }[gamePhase]!;

    return BlocBuilder<HeroBloc, HeroState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(
            top: 8,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(title),
                  const Divider(),
                  if (state.itemsByGamePhase[gamePhase]?.isEmpty ?? false)
                    Center(
                      child: Text(locale.noRecord,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  if (state.itemsByGamePhase[gamePhase]?.isNotEmpty ?? false)
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      crossAxisCount: 9,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: state.itemsByGamePhase[gamePhase]!
                          .map<Widget>(
                            (item) => ItemImage(item),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
