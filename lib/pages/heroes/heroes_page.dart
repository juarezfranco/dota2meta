import 'package:dota2meta/pages/about/about.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/hero_filter_button.dart';
import 'package:dota2meta/pages/heroes/components/filters.dart';
import 'package:dota2meta/pages/heroes/components/heroes_list.dart';
import 'package:dota2meta/repositories/fetch_all_heroes_repository.dart';
import 'package:dota2meta/repositories/fetch_meta_lanes_roles_repository.dart';
import 'package:dota2meta/support/app_container.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeoresPage extends StatelessWidget {
  const HeoresPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => HeroesBloc(
          fetchHeroRepository: AppContainer.resolve<FetchAllHeroesRepository>(),
          fetchMetaLanesRolesRepository: AppContainer.resolve<FetchMetaLanesRolesRepository>(),
        )..add(HeroesStarted()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Dota 2 Meta"),
            actions: [
              const HeroFilterButton(),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text(AppLocalizations.of(context).about),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const About(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          endDrawer: Drawer(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20 + MediaQuery.of(context).padding.top,
              ),
              child: const SingleChildScrollView(
                child: Filters(),
              ),
            ),
          ),
          body: const HeroesList(),
        ),
      ),
    );
  }
}
