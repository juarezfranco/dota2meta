import 'package:dota2meta/pages/hero/components/percent_pick_ban_win.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../widgets/helpers.dart';

void main() {
  testWidgets('Widget heroes components: percent pick ban win',
      (WidgetTester tester) async {

    const percent = 80.0;
    const total = 100;

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        const PercentPickBanWin(percent: percent, total: total),
      ),
    );

    expect(find.text("${percent.toStringAsFixed(1)}%"), findsOneWidget);
    expect(find.text("$total"), findsOneWidget);
  });
}
