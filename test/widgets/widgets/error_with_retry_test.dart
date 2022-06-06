import 'package:dota2meta/widgets/error_with_retry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';

void main() {
  testWidgets('Widget error with retry', (WidgetTester tester) async {
    String retryResponse = "Not pressed";

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        ErrorWithRetry(
          message: "This is a error",
          retryPressed: () => retryResponse = "Has pressed",
        ),
      ),
    );
    expect(find.text("This is a error"), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
    await tester.tap(find.byType(TextButton));
    expect(retryResponse, "Has pressed");
  });
}
