import 'package:dota2meta/enums/attribute.dart';

class AppImages {
  static String getAttributePath(Attribute attribute) {
    if (attribute == Attribute.strength) {
      return "assets/images/strength_attribute_symbol.png";
    }

    if (attribute == Attribute.agility) {
      return "assets/images/agility_attribute_symbol.png";
    }

    return "assets/images/intelligence_attribute_symbol.png";
  }
}