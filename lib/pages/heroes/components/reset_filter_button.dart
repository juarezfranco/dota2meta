import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetFilterButton extends StatelessWidget {
  const ResetFilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        BlocProvider.of<HeroesBloc>(context).add(HeroesFilterReseted());
      },
      child: Text(AppLocalizations.of(context).resetFilter),
    );
  }
}
