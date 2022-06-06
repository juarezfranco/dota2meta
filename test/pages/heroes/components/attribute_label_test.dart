import 'package:dota2meta/enums/attribute.dart';
import 'package:dota2meta/pages/heroes/components/attribute_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: attribute label',
      (WidgetTester tester) async {
    final attrs = [
      {
        "attr": Attribute.strength,
        "asset": "assets/images/strength_attribute_symbol.png",
      },
      {
        "attr": Attribute.agility,
        "asset": "assets/images/agility_attribute_symbol.png",
      },
      {
        "attr": Attribute.intelligence,
        "asset": "assets/images/intelligence_attribute_symbol.png",
      },
    ];

    for (var attr in attrs) {
      await tester.pumpWidget(
        wrapWithMaterialAppAndScaffold(
          AttributeLabel(attr["attr"] as Attribute),
        ),
      );

      final imageFinder = find.byType(Image);
      expect(imageFinder, findsOneWidget);
      final image = tester.firstWidget<Image>(imageFinder);
      expect((image.image as AssetImage).assetName, attr["asset"]);
    }
  });
}
