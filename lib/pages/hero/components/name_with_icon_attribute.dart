import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/support/app_images.dart';
import 'package:flutter/material.dart';
import 'package:dota2meta/models/hero.dart' as model_hero;

class NameWithIconAttribute extends StatelessWidget {
  final model_hero.Hero hero;

  const NameWithIconAttribute(this.hero, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.getAttributePath(hero.primaryAttribute),
          height: 24,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          hero.name,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
