import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/bloc/heroes_bloc.dart';
import 'package:dota2meta/pages/heroes/components/attribute_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeRadioFilter extends StatelessWidget {
  final Attribute attribute;

  const AttributeRadioFilter(this.attribute, {super.key});

  void _selected(BuildContext context) {
    BlocProvider.of<HeroesBloc>(context)
        .add(HeroesAttributeFiltered(attribute));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeroesBloc, HeroesState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => _selected(context),
          child: Row(
            children: [
              SizedBox(
                width: 30,
                child: Radio<Attribute>(
                  groupValue: state.selectedAttribute,
                  value: attribute,
                  onChanged: (value) => _selected(context),
                ),
              ),
              AttributeLabel(attribute, fontSize: 12),
            ],
          ),
        );
      },
    );
  }
}