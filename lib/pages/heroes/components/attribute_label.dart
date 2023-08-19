import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/support/app_images.dart';
import 'package:dota2meta/support/app_localizations.dart';
import 'package:flutter/material.dart';

class AttributeLabel extends StatelessWidget {
  final Attribute attribute;
  final double? fontSize;
  final double? iconSize;
  final Color? textColor;

  const AttributeLabel(
    this.attribute, {
    this.textColor,
    this.fontSize,
    this.iconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 18,
          width: 18,
          child: Image.asset(
            AppImages.getAttributePath(attribute),
            height: iconSize,
            width: iconSize,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          _description(context).toUpperCase(),
          style: Theme.of(context).textTheme.caption?.copyWith(
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  String _description(BuildContext context) {
    if (attribute == Attribute.strength) {
      return AppLocalizations.of(context).strength;
    }

    if (attribute == Attribute.agility) {
      return AppLocalizations.of(context).agility;
    }

    if (attribute == Attribute.intelligence) {
      return AppLocalizations
          .of(context)
          .intelligence;
    }

    return AppLocalizations
        .of(context)
        .universal;
  }
}
