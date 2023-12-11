import 'package:dota2meta/pages/hero/hero_page.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/hero_item.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:dota2meta/widgets/error_with_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _horizontalPadding = 12.0;
const _statsWidth = 180.0;

class HeroesList extends StatelessWidget {
  const HeroesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(),
        Expanded(
          child: BlocBuilder<HeroesBloc, HeroesState>(
            builder: (context, state) {
              final bloc = BlocProvider.of<HeroesBloc>(context);
              List<Widget> children = [];

              if (state.status == HeroesStatus.failure) {
                children.add(
                  ErrorWithRetry(
                    message: state.errorMessage ?? "",
                    retryPressed: () => bloc.add(HeroesFetched()),
                  ),
                );
              }

              if (state.status == HeroesStatus.success || state.heroes.length > 1) {
                children.add(
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.filteredHeroes.length,
                      itemBuilder: (_, index) => HeroItem(
                        state.filteredHeroes[index],
                        horizontalPadding: _horizontalPadding,
                        statsWidth: _statsWidth,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HeroPage(state.filteredHeroes[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Stack(
                children: [
                  Column(
                    children: children,
                  ),
                  if (state.status == HeroesStatus.loading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _horizontalPadding,
      ),
      child: Row(
        children: [
          const Expanded(child: SizedBox()),
          SizedBox(
            width: _statsWidth / 3,
            child: Center(
              child: Text(AppLocalizations.of(context).pick),
            ),
          ),
          SizedBox(
            width: _statsWidth / 3,
            child: Center(
              child: Text(AppLocalizations.of(context).ban),
            ),
          ),
          SizedBox(
            width: _statsWidth / 3,
            child: Center(
              child: Text(AppLocalizations.of(context).win),
            ),
          ),
        ],
      ),
    );
  }
}
