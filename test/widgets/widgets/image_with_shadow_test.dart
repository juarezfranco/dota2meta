import 'package:cached_network_image/cached_network_image.dart';
import 'package:dota2meta/widgets/image_with_shadow.dart';
import 'package:dota2meta/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers.dart';

void main() {
  testWidgets('Widget image with shadow', (WidgetTester tester) async {
    const imageWidth = 800.0;
    const imageHeight = 480.0;
    const link = "http://localhost/image.png";

    await tester.pumpWidget(
      wrapWithMaterialAppAndScaffold(
        const ImageWithShadow(
          url: link,
          width: imageWidth,
          height: imageHeight,
        ),
      ),
    );
    
    // test container has shadow
    final mainContainer = tester.firstWidget<Container>(find.byType(Container));
    expect(mainContainer.decoration is BoxDecoration, true);
    final BoxDecoration boxDecoration = mainContainer.decoration as BoxDecoration;
    expect(boxDecoration.boxShadow?.length ?? 0, 1);

    // test image size and url
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    final imageSize = tester.getSize(find.byType(CachedNetworkImage));
    expect(imageSize.width, imageWidth);
    expect(imageSize.height, imageHeight);
    final image = tester.firstWidget<CachedNetworkImage>(find.byType(CachedNetworkImage));
    expect(image.imageUrl, link);
  });
}
