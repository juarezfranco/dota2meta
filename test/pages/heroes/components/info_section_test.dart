import 'package:dota2meta/pages/heroes/components/info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: info section', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(const InfoSection()),
    );
    final textFinder = find.byType(Text);
    expect(textFinder, findsOneWidget);
    final text = tester.firstWidget<Text>(textFinder);
    expect(text.data, isNotNull);
    expect(text.data!.isNotEmpty, isTrue);
  });
}
