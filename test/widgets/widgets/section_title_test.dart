import 'package:dota2meta/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  testWidgets('Widget section title', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        SectionTitle(
          "This is a test",
          icon: const Icon(Icons.flutter_dash),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
    expect(find.text("This is a test".toUpperCase()), findsOneWidget);
    expect(find.widgetWithIcon(Row, Icons.flutter_dash), findsOneWidget);
    expect(find.widgetWithIcon(Row, Icons.search), findsOneWidget);
  });
}
