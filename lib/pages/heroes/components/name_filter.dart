import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _debounceKey = 'queryString';

class NameFilter extends StatefulWidget {
  const NameFilter({
    super.key,
  });

  @override
  State<NameFilter> createState() => _NameFilterState();
}

class _NameFilterState extends State<NameFilter> {
  @override
  void dispose() {
    EasyDebounce.cancel(_debounceKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppLocalizations.of(context).filter),
        const Divider(),
        TextFormField(
          initialValue: BlocProvider.of<HeroesBloc>(context).state.queryString,
          onChanged: (queryString) => EasyDebounce.debounce(
            _debounceKey,
            const Duration(milliseconds: 500),
            () => BlocProvider.of<HeroesBloc>(context).add(
              HeroesQueryStringChanged(queryString),
            ),
          ),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        )
      ],
    );
  }
}
