import 'package:dota2meta/pages/hero/bloc/hero_bloc.dart';
import 'package:dota2meta/pages/hero/components/group_pick_ban_win.dart';
import 'package:dota2meta/pages/hero/components/hero_image.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;
import 'package:dota2meta/pages/hero/components/items.dart';
import 'package:dota2meta/pages/hero/components/name_with_icon_attribute.dart';
import 'package:dota2meta/repositories/fetch_meta_items_for_hero_repository.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeroPage extends StatelessWidget {
  final model_hero.Hero hero;

  const HeroPage(this.hero, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeroBloc(
        hero: hero,
        fetchMetaItemsForHeroRepository:
            AppContainer.resolve<FetchMetaItemsForHeroRepository>(),
      )..add(HeroStarted()),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          kToolbarHeight + MediaQuery.of(context).padding.top,
                    ),
                    Hero(
                      tag: "img${hero.id}",
                      child: HeroImage(hero),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    NameWithIconAttribute(hero),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text(hero.laneRoleDescription.toUpperCase()),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GroupPickBanWin(hero),
                    const SizedBox(
                      height: 8,
                    ),
                    Items(hero),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0,
              child: SizedBox(
                height: kToolbarHeight,
                width: kToolbarHeight, // copy width from native app_bar.dart
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
